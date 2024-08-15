Rails.application.routes.draw do
  get 'store/index'
  resources :products
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'home/show', to: 'home#show'

  # Defines the root path route ("/")
  root "home#index"
end
