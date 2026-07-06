Rails.application.routes.draw do
  resources :articles
  root "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
  get "about", to: "pages#about"
  resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  get "signup", to: "users#new"
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
