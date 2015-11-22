json.array!(@api_v1_lessons) do |api_v1_lesson|
  json.extract! api_v1_lesson, :id
  json.url api_v1_lesson_url(api_v1_lesson, format: :json)
end
