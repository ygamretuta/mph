Mbb::Application.routes.draw do
  resources :pictures

  #devise routes
  devise_for :users, path:'accounts'

  root 'pages#index'

  # resource routes
  resources :users, only:[:show, :update] do
    resources :items do
      resources :pictures
    end
  end

  get '/search' => 'pages#search', as:'search'
end