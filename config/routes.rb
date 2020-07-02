# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root "home#index"
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  get "signup", to: "signup#new"
  resources :users, only: [:new, :create] do
    member do
      get :activate
    end
  end

  resources :password_resets, only: [:index, :create, :edit, :update]
  resources :unconfirmed_email, only: [] do
    member do
      get "confirm"
    end
  end

  resources :forms

  resource :account, only: [:show, :destroy] do
    resource :password, only: [:edit, :update], controller: "account/passwords"
    resource :email, only: [:edit, :update], controller: "account/email"
  end

  namespace :api do
    namespace :v1 do
      resources :forms, only: [:show]
      post "forms(/:id)", to: "forms#create"
    end
  end
  resource :document, only: [:show] do
    get "sampleform", to: "document/sampleform#index", as: "sampleform"
  end

  get "thankyou", to: "thankyou#index", as: "thankyou"
  get "welcome", to: "welcome#index", as: "welcome"
end
