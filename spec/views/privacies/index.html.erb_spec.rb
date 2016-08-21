require 'rails_helper'

RSpec.describe "privacies/index", :type => :view do
  before(:each) do
    assign(:privacies, [
      Privacy.create!(
        :document => nil
      ),
      Privacy.create!(
        :document => nil
      )
    ])
  end

  it "renders a list of privacies" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
