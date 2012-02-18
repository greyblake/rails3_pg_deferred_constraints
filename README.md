# Rails3 PG deferred constraints

Copyright: 2011 TMX Credit

Author: Potapov Sergey (aka Blake)


## Intro

This is a Rails 3 engine which provides a hack to avoid
[RI\_ConstraintTrigger Error bug](http://kopongo.com/2008/7/25/postgres-ri_constrainttrigger-error).

It tested with PosgreSQL 9.0.4 and Rails 3.1.0

## Usage

I would recommend to use it only for tests and __NEVER USE IN PRODUCTION__

Add to your Gemfile:

    group :test do
      gem 'rails3_pg_deferred_constraints'
    end

## Testing

* `cd test/dummy && bundle install`
* Open ./test/dummy/config/database.yml and modified db connections
* Run `rake test` from the root directory of gem(not dummy application)
