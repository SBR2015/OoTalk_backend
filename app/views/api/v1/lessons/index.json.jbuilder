json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :title
  json.url api_v1_course_lesson_url(@course.id, lesson, format: :json)
end
