require 'rails_helper'

RSpec.describe "permissions/edit", :type => :view do
  before(:each) do
    @permission = assign(:permission, Permission.create!(
      :write => false,
      :share => false
    ))
  end

  it "renders the edit permission form" do
    render

    assert_select "form[action=?][method=?]", permission_path(@permission), "post" do

      assert_select "input#permission_write[name=?]", "permission[write]"

      assert_select "input#permission_share[name=?]", "permission[share]"
    end
  end
end
