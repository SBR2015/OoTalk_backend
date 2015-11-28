json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :title, :body, :course_id, :created_at, :updated_at, :order
end
