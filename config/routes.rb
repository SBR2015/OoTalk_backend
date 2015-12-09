Rails.application.routes.draw do
  # Static Page
  root 'staticsite#index'

  # Coding Page
  get '/code', to: 'code#index'

  resources :courses, only: [:index] do
    resources :lessons, only: [:index, :show]
  end
  # Json Coding page
  resources :code_json, only: [:index], path: :codejson

  # Doorkeeper
  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end

  # Rails Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Devise
  devise_for :users

  # API v1
  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      resources :abstract_syntax, only: [:show], param: :language, path: :abstractsyntax
      resources :execute
      resources :courses, except: [:new, :edit] do
        resources :lessons, except: [:new, :edit]
      end
      get 'users/profile'
    end
  end
end
