Rails.application.routes.draw do
  devise_for :users

  root to: 'words#index'
  resources :words do
    collection do
      get 'search'
    end
    member do
      patch 'myword_update'
      put 'myword_update'
      delete 'myword_destroy'
    end
    resources :favorites, only: [:index, :create, :destroy]
  end
  resources :users, only: :show
end
