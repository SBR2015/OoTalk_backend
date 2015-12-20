Rails.application.routes.draw do
  # Static Page
  # root 'staticsite#index'

  # Coding Page
  # get '/code', to: 'code#index'

  # Json Coding page
  # resources :code_json, only: [:index], path: :codejson
  # get '/codejson', to: 'code_json#index'
  # Doorkeeper
  # use_doorkeeper do
  #   controllers :applications => 'oauth/applications'
  # end
  
  # Frontend App
  mount_ember_app :frontend, to: "/"

  # Rails Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Devise
  devise_for :users, controllers: { confirmations: 'confirmations' }

  # API v1
  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      resources :abstract_syntax, only: [:show], param: :language ,path: :abstractsyntax
      resources :execute
      resources :courses, except: [:new, :edit] do
        resources :lessons, except: [:new, :edit]
      end

      mount_devise_token_auth_for 'User', at: 'auth'

      # authorization needed
      get 'users/profile', to: 'users#profile'
      get 'users/code', to: 'users#code'
    end
  end
end
