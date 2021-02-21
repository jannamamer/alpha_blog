# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'chatroom', to: 'chatroom#index'
  post 'message', to: 'messages#create'
  
  get 'search_stock', to: 'stocks#search'
  get 'search_friend', to: 'friends#search'

  resources :articles
  resources :categories, except: [:destroy]
  resources :look_ups, except: [:destroy]
  resources :users, only: %i[index show]
  resources :stocks, only: [:index]
  resources :user_stocks, only: [:create, :destroy]
  resources :friends, only: [:index, :destroy]

  mount ActionCable.server, at: '/cable'
end
