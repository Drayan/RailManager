require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "application#index"
  get "/dashboard" => "application#dashboard"

  resources :customers do
    resources :order_rules
  end

  resources :orders

  resources :car_types do
    resources :car_models
  end

  resources :yards
  resources :tracks
  resources :trains
  post "/trains/spawn" => "trains#spawn_train"
  resources :local_trains
  resources :spawn_points
  resources :supply_train_blueprints

  mount Sidekiq::Web => '/dev/jobs'
end
