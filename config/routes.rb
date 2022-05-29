Rails.application.routes.draw do

  get 'carts/show', to: "carts#show", as:'cart'
  delete 'carts/:id', to: "carts#destroy"

  post 'cart_items/:id/add', to: "cart_items#add_quantity", as:'cart_item_add'
  post 'cart_items/:id/reduce', to: "cart_items#reduce_quantity", as:'cart_item_reduce'

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
  resources :cart_items
  resources :carts do
    resources :payments
  end


end

