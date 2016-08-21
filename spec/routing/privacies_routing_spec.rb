require "rails_helper"

RSpec.describe PrivaciesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/privacies").to route_to("privacies#index")
    end

    it "routes to #new" do
      expect(:get => "/privacies/new").to route_to("privacies#new")
    end

    it "routes to #show" do
      expect(:get => "/privacies/1").to route_to("privacies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/privacies/1/edit").to route_to("privacies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/privacies").to route_to("privacies#create")
    end

    it "routes to #update" do
      expect(:put => "/privacies/1").to route_to("privacies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/privacies/1").to route_to("privacies#destroy", :id => "1")
    end

  end
end
