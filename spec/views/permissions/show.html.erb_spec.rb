require 'rails_helper'

RSpec.describe "permissions/show", :type => :view do
  before(:each) do
    @permission = assign(:permission, Permission.create!(
      :write => false,
      :share => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
