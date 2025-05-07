Rails.application.routes.draw do
  resources :series
  resources :ebooks
  require 'sidekiq/web'

  authenticate :user, ->(user) { user.admin_role? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  namespace :admin do
    #get "dashboard", to: "dashboard#index"
    resources :publishers
    resources :users
    root to: 'dashboard#index'
  end

  get '/profil', to: 'users#profile', as: :profile
  devise_for :users
  resources :users, only: %i(update) do
    patch :update_password, on: :member
  end

  resources :publishers do

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :language, only: [:index, :show]
  resources :authors, only: [:index, :show]
  # Defines the root path route ("/")
  root to: 'home#index'
end
