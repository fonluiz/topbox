require 'rails_helper'

RSpec.describe "privacies/new", :type => :view do
  before(:each) do
    assign(:privacy, Privacy.new(
      :document => nil
    ))
  end

  it "renders new privacy form" do
    render

    assert_select "form[action=?][method=?]", privacies_path, "post" do

      assert_select "input#privacy_document_id[name=?]", "privacy[document_id]"
    end
  end
end
