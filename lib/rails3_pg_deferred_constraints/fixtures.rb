# We also need to redefine ActiveRecord::Fixtures.create_fixtures method to
# make it use TRUNCATE instead of DELETE FROM since DELETE FROM raises exception
# when we violate foreign key constrant:
#   ActiveRecord::InvalidForeignKey: PGError: ERROR:  update or delete on table 
#   "table_1" violates foreign key constraint "foreign_key_name" on table "table_2"
#   DETAIL:  Key (id)=(1) is still referenced from table "table_2".
#   : DELETE FROM "table_1"
require 'rails/test_help'

class ::ActiveRecord::Fixtures

  # it is almost original method except using TRUCTATE for all tables with one query
  # instead of deleting records table by table with DELETE FROM
  def self.create_fixtures(fixtures_directory, table_names, class_names = {})
    table_names = [table_names].flatten.map { |n| n.to_s }
    table_names.each { |n|
      class_names[n.tr('/', '_').to_sym] = n.classify if n.include?('/')
    }

    # FIXME: Apparently JK uses this.
    connection = block_given? ? yield : ActiveRecord::Base.connection

    files_to_read = table_names.reject { |table_name|
      fixture_is_cached?(connection, table_name)
    }

    unless files_to_read.empty?
      connection.disable_referential_integrity do
        fixtures_map = {}

        fixture_files = files_to_read.map do |path|
          table_name = path.tr '/', '_'

          fixtures_map[path] = ActiveRecord::Fixtures.new(
            connection,
            table_name,
            class_names[table_name.to_sym] || table_name.classify,
            File.join(fixtures_directory, path))
        end

        all_loaded_fixtures.update(fixtures_map)

        connection.transaction(:requires_new => true) do
          
          quoted_tables = fixture_files.map(&:table_rows).flatten.map(&:keys).flatten.map{ |t| connection.quote_table_name(t) }
          connection.delete "TRUNCATE #{quoted_tables.join(', ')}"

          fixture_files.each do |ff|
            conn = ff.model_class.respond_to?(:connection) ? ff.model_class.connection : connection
            table_rows = ff.table_rows

            table_rows.each do |table_name,rows|
              rows.each do |row|
                conn.insert_fixture(row, table_name)
              end
            end
          end

          # Cap primary key sequences to max(pk).
          if connection.respond_to?(:reset_pk_sequence!)
            table_names.each do |table_name|
              connection.reset_pk_sequence!(table_name.tr('/', '_'))
            end
          end
        end

        cache_fixtures(connection, fixtures_map)
      end
    end
    cached_fixtures(connection, table_names)
  end
end
