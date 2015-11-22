require 'rails_helper'

RSpec.describe "Api::V1::Courses", type: :request do
  describe "GET /api_v1_courses" do
    it "works! (now write some real specs)" do
      get api_v1_courses_path(format: :json)
      expect(response).to have_http_status(200)
    end
  end
end
