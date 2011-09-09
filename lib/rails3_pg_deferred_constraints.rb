module Rails3PgDeferredConstraints
  class Engine < Rails::Engine
    initializer 'pg_deffer_constraints', :after => :disable_dependency_loading do |app|

      require 'rails3_pg_deferred_constraints/postgresql_adapter'
      require 'rails3_pg_deferred_constraints/fixtures'

    end
  end
end
