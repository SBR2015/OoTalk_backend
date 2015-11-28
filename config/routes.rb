Rails.application.routes.draw do
  scope "(:lang)" do
    resources :products
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # Coding page
  root 'code#index'

  # Json Coding page
  resources :code_json, only: [:index], path: :codejson

  # API v1
  namespace :api do
    namespace :v1 do
      resources :abstract_syntax, only: [:show], param: :language ,path: :abstractsyntax
      resources :execute
      resources :courses, except: [:new, :edit] do
        resources :lessons, except: [:new, :edit]
      end
      resources :useractivty, except: [:new, :edit]
    end
  end
end
