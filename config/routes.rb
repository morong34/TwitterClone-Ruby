# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_names
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'

  resources :tweets, only: :create
  get :dashboard, to: 'dashboard#index'
end
