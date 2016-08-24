require 'rails_helper'

RSpec.describe "privacies/show", :type => :view do
  before(:each) do
    @privacy = assign(:privacy, Privacy.create!(
      :document => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
