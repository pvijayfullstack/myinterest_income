require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
#  should "add two numbers for the sum(dummy test)" do
#    cal = 4
#    assert_equal 4, cal
#  end
  should_validate_presence_of :name
  should_have_many :investments, :dependent => :destroy
end
