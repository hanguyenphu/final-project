# frozen_string_literal: true

Rails.application.routes.draw do
  get 'feature/index'
  get 'feature/:id', to: 'feature#show'
  get 'category/index'
  get 'category/show'
  get 'about/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'contact/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'welcome/index'

  root 'about#index'
end
