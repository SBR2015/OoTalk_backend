json.user_id @user.id
json.set! :codes do
  json.array! @codes do |code|
    json.id code.id
    json.title code.title
    json.description code.description
    json.code code.code
    json.created_at code.created_at
    json.updated_at code.updated_at
  end
end
