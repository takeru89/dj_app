Rails.application.routes.draw do
  devise_for :users

  root to: 'words#index'
  resources :words do
    collection do
      get 'search'
    end
    member do
      get 'from_mypage_edit'
      patch 'from_mypage_update'
      put 'from_mypage_update'
      delete 'from_mypage_destroy'
    end
  end
  resources :users, only: :show
end
