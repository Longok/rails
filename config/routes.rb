Rails.application.routes.draw do
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

  resources :users

  root 'static_pages#home'
end
