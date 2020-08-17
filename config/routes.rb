Rails.application.routes.draw do
  devise_for :users

  root to: 'words#index'
  resources :words do
    collection do
      get 'search'
    end
  end
end
