json.array!(@demos) do |demo|
  json.extract! demo, :id
  json.url demo_url(demo, format: :json)
end
