# frozen_string_literal: true
Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  root 'application#angular'
  resources :projects
  get '/tasks/statuses', to: 'tasks#statuses'
  resources :tasks do
    resources :comments, only: [:create, :destroy, :update]
  end
end
