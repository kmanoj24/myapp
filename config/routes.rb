Rails.application.routes.draw do
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

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'dashboard', to: 'dashboard#index'

  
  get 'customers/index'
  get 'customers/show'
  get 'customers/create'
  get 'customers/update'
  get 'customers/destroy'
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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  resources :actors, only: [:index, :show, :create, :update, :destroy]
  resources :films, only: [:index, :show, :create, :update, :destroy]
  resources :customers, only: [:index, :show, :create, :update, :destroy]
  # Defines the root path route ("/")
  # root "posts#index"
end
