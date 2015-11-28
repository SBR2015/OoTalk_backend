json.array!(@courses) do |course|
  json.extract! course, :id, :title, :level, :created_at, :updated_at
end
