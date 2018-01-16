require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @company = Company.new(name: "ACME Corporation", 
                           alias: "ACME", address1: "", address2: "",
                           city: "", post_code: "", country: "",
                           email: "acme@example.com", contact_number: "" )
    @project = Project.new(code: "PE790", company: @company)
  end
  
  test "should be valid" do
    assert @project.valid?
  end
  
  test "code should be present" do
    @project.code = "     "
    assert_not @project.valid?
  end
end
