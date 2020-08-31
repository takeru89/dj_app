Rails.application.routes.draw do
  devise_for :users

  root to: 'words#index'

  resources :words do
    collection do
      get 'search'
    end
    member do
      delete 'myword_destroy'
    end
    resources :favorites, only: [:create, :destroy]
  end

  resources :users, only: :show do
    resources :favorites, only: [:index]
  end

  resources :requests, only: [:create, :destroy]
end
