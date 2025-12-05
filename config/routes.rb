Rails.application.routes.draw do
  get 'home/index'
  resources :products
  devise_for :users
  authenticate :user, ->(user) { user.admin? } do
    resources :products
    resources :sizes
  end

  root "home#index"
  resources :products, only: [:index, :show]
  get    "/cart",     to: "cart#show",    as: :cart
  post   "/cart/add", to: "cart#add",     as: :add_to_cart
  delete "/cart/remove", to: "cart#remove", as: :remove_from_cart
  post "/cart/increase", to: "cart#increase", as: :increase_in_cart
  post   "/cart/checkout", to: "cart#checkout", as: :checkout_cart


  get "/orders", to: "orders#index", as: :orders
  post   "/checkout",  to: "orders#create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
