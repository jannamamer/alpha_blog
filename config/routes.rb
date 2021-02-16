# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_stocks
  devise_for :users

  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'chatroom', to: 'chatroom#index'
  post 'message', to: 'messages#create'
  
  get 'search_stock', to: 'stocks#search'

  resources :articles
  resources :categories, except: [:destroy]
  resources :look_ups, except: [:destroy]
  resources :users, only: %i[index show]
  resources :stocks, only: [:index]

  mount ActionCable.server, at: '/cable'
end
