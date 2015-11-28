require "rails_helper"

RSpec.describe Api::V1::LessonsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/v1/courses/1/lessons").to route_to("api/v1/lessons#index", :course_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/api/v1/courses/1/lessons/1").to route_to("api/v1/lessons#show", :id => "1", :course_id => "1")
    end

    it "routes to #create" do
      expect(:post => "/api/v1/courses/1/lessons").to route_to("api/v1/lessons#create", :course_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/v1/courses/1/lessons/1").to route_to("api/v1/lessons#update", :id => "1", :course_id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/v1/courses/1/lessons/1").to route_to("api/v1/lessons#update", :id => "1", :course_id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/courses/1/lessons/1").to route_to("api/v1/lessons#destroy", :id => "1", :course_id => "1")
    end

  end
end
