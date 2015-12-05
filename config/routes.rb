Rails.application.routes.draw do
  # Coding page
  root 'code#index'
  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # Json Coding page
  resources :code_json, only: [:index], path: :codejson
  # API v1
  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      resources :abstract_syntax, only: [:show], param: :language ,path: :abstractsyntax
      resources :execute
      resources :courses, except: [:new, :edit] do
        resources :lessons, except: [:new, :edit]
      end
      get 'users/profile'
    end
  end
end
