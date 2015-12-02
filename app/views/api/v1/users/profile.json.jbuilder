json.extract! @user, :id, :email
json.set! :activities do
  json.array! @user.useractivities do |activity|
    json.id activity.id
    json.course activity.course
    json.lesson activity.lesson
  end
end