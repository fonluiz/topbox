require 'rails_helper'

RSpec.describe "permissions/new", :type => :view do
  before(:each) do
    assign(:permission, Permission.new(
      :write => false,
      :share => false
    ))
  end

  it "renders new permission form" do
    render

    assert_select "form[action=?][method=?]", permissions_path, "post" do

      assert_select "input#permission_write[name=?]", "permission[write]"

      assert_select "input#permission_share[name=?]", "permission[share]"
    end
  end
end
