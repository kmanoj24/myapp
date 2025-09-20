require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do
  get 'subscriptions/create'
  mount Sidekiq::Web => '/sidekiq'
  root 'forecast#index'
  post 'forecast/show', to: 'forecast#show', as: 'forecast_show'
  get 'users/new'
  get 'dashboard/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'users/new'
  get 'users/create'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'goods/gc_stats', to: 'goods#gc_stats'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'dashboard', to: 'dashboard#index'
  get '/callback', to: 'gmail#callback'
  get '/auth', to: 'gmail#auth'
  get '/recent_emails', to: 'gmail#recent_emails'

  get "/chat", to: "chat#index"
  post "/chat", to: "chat#create"
  get "/chat/voice", to: "chat#voice"

  get "goods", to: "goods#index"
  get "goods/:id", to: "goods#actor_details", as: "actor_details"
  get '/check_models', to: 'chat#check_models'
  get '/create_character', to: 'chat#create_character', as: 'create_character'
  post '/submit_character', to: 'chat#submit_character', as: 'submit_character'

  Rails.application.routes.draw do
  get 'subscriptions/create'
    namespace :api do
      resources :customers do
        collection do
          get 'search'
          get 'export'
        end
  
        member do
          get 'profile'
          post 'activate'
        end
      end
    end
  end
  
  get 'films/index'
  get 'films/show'
  get 'films/create'
  get 'films/update'
  get 'films/destroy'
  get 'actors/index'
  get 'actors/show'
  get 'actors/create'
  get 'actors/update'
  get 'actors/destroy'

  get "up" => "rails/health#show", as: :rails_health_check
  resources :users, only: [:new, :create]
  # config/routes.rb
  post '/subscribe', to: 'subscriptions#create', as: 'subscribe'

  resources :actors, only: [:index, :show, :create, :update, :destroy]
  resources :films, only: [:index, :show, :create, :update, :destroy]
  resources :customers, only: [:index, :show, :create, :update, :destroy]
end
