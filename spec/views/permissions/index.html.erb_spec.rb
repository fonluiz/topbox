require 'rails_helper'

RSpec.describe "permissions/index", :type => :view do
  before(:each) do
    assign(:permissions, [
      Permission.create!(
        :write => false,
        :share => false
      ),
      Permission.create!(
        :write => false,
        :share => false
      )
    ])
  end

  it "renders a list of permissions" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
