require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @company = Company.new(name: "ACME")
    @project = Project.new(code: "PE788", company: @company)
  end
  
  test "should be valid" do
    assert @project.valid?
  end
  
  test "code should be present" do
    @project.code = "     "
    assert_not @project.valid?
  end
end
