require 'rails_helper'

RSpec.describe "Api::V1::Lessons", type: :request do
  describe "GET /api_v1_lessons" do
    it "works! (now write some real specs)" do
      get api_v1_course_lessons_path(:course_id => "1", format: :json)
      expect(response).to have_http_status(200)
    end
  end
end
