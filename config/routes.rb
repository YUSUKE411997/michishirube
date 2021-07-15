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
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  scope module: :users do
    root to: 'homes#top'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get :follows, on: :member
      get :followers, on: :member
      get :user_likes, on: :member
      get :user_type, on: :member
      get :user_previews, on: :member
      get :destroy_confirm, on: :member
      patch :withdraw, on: :member
    end
    resources :posts, only: [:index, :show, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
      resources :reposts, only: [:create, :destroy]
      get :type_index, on: :collection
      get :ranks_show, on: :collection
    end
    resources :rooms, only: [:index, :show] do
      resource :messages, only: [:create]
    end
    resources :notifications, only: [:index] do
      delete :destroy_all, on: :collection
    end
    resources :plans, only: [:index, :create]
    resources :timelines, only: [:index]
    get 'tags/:tag_id/posts' => 'posts#tag_index', as: :tag_posts
    get 'search' => 'searches#search'
  end

  namespace :admin do
    get 'search' => 'searches#search'
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
      get :type_index, on: :collection
    end
  end

end
