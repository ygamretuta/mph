Mbb::Application.routes.draw do
  get 'notifications/index' => 'notifications#index', as:'notifications'
  delete 'notifications/destroy'

  root 'pages#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers:{registrations:'registrations', omniauth_callbacks:'users/omniauth_callbacks'}
  resources :items, only:[:index]


  # resource routes
  resources :users, only:[:show, :update] do
    resources :transactions, only:[:index, :show]

    resources :items do
      resources :transactions
      resources :pictures, only:[:new, :create, :destroy]
    end
  end

  get '/top_users' => 'users#index', as:'top_users'
  get '/search' => 'pages#search', as:'search'
  get '/profile' => 'users#profile', as:'profile'
  get '/edit_profile'=> 'users#edit', as:'edit_profile'
  get '/purchases' => 'transactions#purchases', as:'purchases'
  get '/sales' => 'transactions#sales', as:'sales'
  get '/:username/purchases' => 'users#purchases', as: 'user_purchases'
  get '/:username/sales' => 'users#sales', as:'user_sales'
  put '/buyer_confirm/:id' => 'transactions#buyer_confirm', as: 'buyer_confirm_transaction'
  put '/seller_confirm/:id' => 'transactions#seller_confirm', as: 'seller_confirm_transaction'
end