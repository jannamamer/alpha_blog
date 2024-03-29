# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'pages#home'

  get 'about', to: 'pages#about'
  get 'chatroom', to: 'chatroom#index'
  post 'message', to: 'messages#create'

  get 'search_friend', to: 'friends#search'

  resources :articles
  resources :categories, except: [:destroy]
  resources :look_ups, except: [:destroy]
  resources :users, only: %i[index show]
  resources :friends, only: %i[index create destroy]

  mount ActionCable.server, at: '/cable'
end
