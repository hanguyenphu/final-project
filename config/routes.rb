# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  get 'status/index'
  get 'feature/index'
  get 'feature/:id', to: 'feature#show'
  get 'category/index'
  get 'category/:id', to: 'category#show'
  get 'about/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'contact/index'

  get 'shopping_cart/index', to: 'shopping_cart#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'welcome/index'

  post 'add_to_cart', to: 'shopping_cart#add_to_cart', as: 'add_to_cart'
  post 'remove_from_cart', to: 'shopping_cart#remove_from_cart', as: 'remove_from_cart'
  # delete 'remove_from_cart/:id', to: 'shopping_cart#remove_from_cart', as: 'remove_from_cart'

  # resources :shopping_cart

  root 'about#index'
end
