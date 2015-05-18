json.array!(@demos) do |demo|
  json.extract! demo, :id
  json.url api_v1_demo_url(demo, format: :json)
end
