Rails.application.routes.draw do
  root 'static_pages#home'
  
  get 'static_pages/home'
  get 'static_pages/help'

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  
  get 'sign-up', to: 'users#new'
  post 'sign-up', to: 'users#create'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy, :show]
  resources :relationships, only: [:create, :destroy]
  
end

