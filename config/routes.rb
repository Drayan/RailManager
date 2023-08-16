Rails.application.routes.draw do
  namespace :admin do
      resources :car_models
      resources :car_types
      resources :customers
      resources :order_rules

      root to: "customers#index"
    end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#index"

  resources :customers do
    resources :order_rules
  end
end
