# Rails3 PG deferred constraints

This is a Rails 3 engine which provides a hack to avoid
[RI\_ConstraintTrigger Error bug](http://kopongo.com/2008/7/25/postgres-ri_constrainttrigger-error).

It tested with PosgreSQL 9.0.4 and Rails 3.1.0

# Usage

I would recommend to use it only for tests and __NEVER USE IN PRODUCTION__

Add to your Gemfile:

    group :test do
      gem 'rails3_pg_deferred_constraints'
    end
