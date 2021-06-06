Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  scope module: :users do
    root to: 'homes#top'
    get 'search' => 'searches#search'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get :follows, on: :member
      get :followers, on: :member
      get :user_likes, on: :member
      get :user_type, on: :member
    end
    get 'users/:id/destroy_confirm' => 'users#destroy_confirm', as: :destroy_confirm
    patch 'users/:id/withdraw' => 'users#withdraw', as: :withdraw
    resources :posts, only: [:index, :show, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
    resources :tags do
      get 'posts', to: 'posts#tag_index'
    end
    resources :notifications, only: [:index]
    # 下記をpostにあとでネスト
    get 'types' => 'posts#type_index'
  end

  namespace :admin do
    get 'search' => 'searches#search'
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    get 'types' => 'posts#type_index'
  end

end
