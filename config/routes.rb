# frozen_string_literal: true

Rails.application.routes.draw do
  # FormApp details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  resource :user, only: [:new, :create]
end
