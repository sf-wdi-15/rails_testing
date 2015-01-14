Rails.application.routes.draw do

  root to: "sites#index"

  get "/contact", to: "sites#contact", as: "contact"

  get "/about", to: "sites#about", as: "about"

  resources :articles

  resources :users, except: [:index, :new]

  get "/sign_up", to: "users#new"
  resources :sessions, only: [:create, :destroy]

  get "/login", to: "sessions#new", as: "login"
end
