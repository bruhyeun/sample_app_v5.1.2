require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def setup
    @company = Company.new(name: "ACME")
  end
  
  test "should be valid" do
    assert @company.valid?
  end
  
  test "name should be present" do
    @company.name = "     "
    assert_not @company.valid?
  end
end
