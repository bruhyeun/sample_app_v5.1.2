require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def setup
    @company = Company.new(name: "ACME Corporation", 
                           alias: "ACME", address1: "", address2: "",
                           city: "", post_code: "", country: "",
                           email: "acme@example.com", contact_number: "" )
  end
  
  test "should be valid" do
    assert @company.valid?
  end
  
  test "name should be present" do
    @company.name = "     "
    assert_not @company.valid?
  end
end
