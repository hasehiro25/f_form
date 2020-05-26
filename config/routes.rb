# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  resources :users, only: [:new, :create] do
    member do
      get :activate
    end
  end
end
