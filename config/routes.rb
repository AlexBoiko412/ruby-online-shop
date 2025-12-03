Rails.application.routes.draw do
  get 'home/index'
  resources :products
  devise_for :users
  authenticate :user, ->(user) { user.admin? } do
    resources :products
    resources :sizes
  end

  root 'home#index'
  resources :products, only: [:index, :show]
  resources :cart_items, only: [:create, :destroy]
  post '/add_to_cart', to: 'cart_items#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
