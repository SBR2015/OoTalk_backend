FactoryGirl.define do
  factory :user do
    email                  "user@example.com"
    password               "password"
    password_confirmation  "password"
    confirmed_at           Date.today
  end
  
  factory :admin do
    email                  "user_admin@example.com"
    password               "password_admin"
    password_confirmation  "password_admin"
    admin                  true
    confirmed_at           Date.today
  end
end
