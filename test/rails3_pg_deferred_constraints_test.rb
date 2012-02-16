require 'test/unit'

class Rails3PgDeferredConstraintsTest < Test::Unit::TestCase

  def run_dummy_test
    book_test = File.expand_path(File.join(File.dirname(__FILE__), 'dummy', 'test', 'unit', 'book_test.rb'))
    %x{#{RbConfig.ruby} #{book_test} 2>&1}
  end


  def test_dummy_tests_fail_if_fix_not_loaded
    ENV['PG_DEFERRED_CONSTRAINTS'] = nil
    assert run_dummy_test =~ /RI_ConstraintTrigger_/
  end

  def test_dummy_tests_pass_if_fix_loaded
    ENV['PG_DEFERRED_CONSTRAINTS'] = 'true'
    assert run_dummy_test !~ /RI_ConstraintTrigger_/
  end

end
