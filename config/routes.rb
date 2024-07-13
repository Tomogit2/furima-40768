Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :users, only: [:update]
  resources :items, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :purchases, only: [:new, :create]
end
