#require 'test_helper'

require File.join(File.dirname(__FILE__), '..', 'test_helper')


class BookTest < ActiveSupport::TestCase
  fixtures(:users)
  fixtures(:books)

  test "do something to load fixtures into the database" do
    assert true
  end
end
