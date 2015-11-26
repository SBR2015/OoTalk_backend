require 'rails_helper'

RSpec.describe "Api::V1::Lessons", type: :request do
  before :each do
    @course = FactoryGirl.create(:course)
    @lesson = FactoryGirl.create(:lesson)
  end

  describe "GET /api/v1/courses/1/lessons" do
    it "works! (now write some real specs)" do
      get api_v1_course_lessons_path(course_id: @course.id.to_s, format: :json)
      expect(response).to have_http_status(200)
    end
  end
end
