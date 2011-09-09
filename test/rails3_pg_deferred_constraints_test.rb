require 'test_helper'

class Rails3PgDeferredConstraintsTest < ActiveSupport::TestCase

  def run_dummy_test
    %x( cd test/dummy; ruby  ./test/unit/book_test.rb 2>&1 )
  end


  test "dummy tests fail without rails3_pg_deferred_constraints egine" do
    output = run_dummy_test
    ENV['PG_DEFERRED_CONSTRAINTS'] = nil
    assert(output =~ /RI_ConstraintTrigger_/)
  end

  test "dummy tests pass if the rails3_pg_deferred_constraints egine is loaded" do
    ENV['PG_DEFERRED_CONSTRAINTS'] = 'true'
    output = run_dummy_test
    assert !(output =~ /RI_ConstraintTrigger_/)
  end

end
