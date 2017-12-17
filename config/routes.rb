Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
    member do
      get :comments
    end
  end
  resources :comments, only: [:create, :destroy] do
    collection do
      get :most_active_users
    end
  end
end
