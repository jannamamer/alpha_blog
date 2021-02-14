# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'chatroom', to: 'chatroom#index'
  post 'message', to: 'messages#create'

  resources :articles
  resources :categories, except: [:destroy]
  resources :look_ups, except: [:destroy]
  resources :users, only: %i[index show]

  mount ActionCable.server, at: '/cable'
end
