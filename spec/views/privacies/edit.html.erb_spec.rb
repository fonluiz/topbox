require 'rails_helper'

RSpec.describe "privacies/edit", :type => :view do
  before(:each) do
    @privacy = assign(:privacy, Privacy.create!(
      :document => nil
    ))
  end

  it "renders the edit privacy form" do
    render

    assert_select "form[action=?][method=?]", privacy_path(@privacy), "post" do

      assert_select "input#privacy_document_id[name=?]", "privacy[document_id]"
    end
  end
end
