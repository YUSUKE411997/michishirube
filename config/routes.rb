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
    resources :users, only: [:show, :edit, :update]
    get 'users/:id/destroy_confirm' => 'users#destroy_confirm', as: :destroy_confirm
    patch 'users/:id/withdraw' => 'users#withdraw', as: :withdraw
    resources :posts, only: [:index, :show, :create, :destroy]
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy]
    get 'admin/type_index' => 'admin#type_index', as: :type_index

  end

end
