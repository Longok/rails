Rails.application.routes.draw do

  get 'carts/:id', to: "carts#show", as:'cart'
  delete 'carts/:id', to: "carts#destroy"
 
  post 'bills/:id/add', to: "bills#add_quantity", as:'bill_add'
  post 'bills/:id/reduce', to: "bills#reduce_quantity", as:'bill_reduce'

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
  resources :products
  resources :bills


end

