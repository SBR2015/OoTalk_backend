json.array!(@courses) do |course|
  json.extract! course, :id
  json.url api_v1_course_url(course, format: :json)
end
