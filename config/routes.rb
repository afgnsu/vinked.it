VinkedIt::Application.routes.draw do
  #devise_for :users, controllers: { registrations: "registrations"}
  devise_for :users

  resources :users

  root to: "home#index"

end