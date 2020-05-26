# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  resource :user, only: [:new, :create]
end
