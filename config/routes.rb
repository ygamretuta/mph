Mbb::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  #devise routes
  devise_for :users

  root 'pages#index'

  resources :items, only:[:index]

  # resource routes
  resources :users, only:[:show, :update] do
    resources :items do
      resources :pictures
    end
  end

  get '/search' => 'pages#search', as:'search'
end