# Hack to disable_referential_integrity for postgres users with sane
# permissions, uses deferral of constraints instead of disablement of the
# superuser-owned per-table triggers. Allows testing with fixtures which
# otherwise produce RI_ConstraintTrigger Errors.
#
# source: http://kopongo.com/2008/7/25/postgres-ri_constrainttrigger-error
# ref: https://github.com/matthuhiggins/foreigner/issues/61
class ::ActiveRecord::ConnectionAdapters::PostgreSQLAdapter < ::ActiveRecord::ConnectionAdapters::AbstractAdapter

  alias_method :supports_deferring_all_constraints?, :supports_disable_referential_integrity?
  def defer_all_constraints(&block)
    return unless supports_deferring_all_constraints?

    transaction do
      begin
        execute "SET CONSTRAINTS ALL DEFERRED"
        yield
      ensure
        execute "SET CONSTRAINTS ALL IMMEDIATE"
      end
    end
  end
  alias_method :disable_triggers_on_each_table, :disable_referential_integrity
  alias_method :disable_referential_integrity, :defer_all_constraints

end
