Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :users, only: [:update]
  resources :items, only: [:new, :create, :index]
end
