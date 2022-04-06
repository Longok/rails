Rails.application.routes.draw do
  get 'sign-up', to: 'users#new'
  post 'sign-up', to: 'users#create'

  resources :users

end
