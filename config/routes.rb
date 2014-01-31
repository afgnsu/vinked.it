VinkedIt::Application.routes.draw do
  #devise_for :users, controllers: { registrations: "registrations"}
  devise_for :users

  resources :users
  resources :countries, except: [:show]
  resources :leagues, except: [:show]
  resources :clubs, except: [:show]
  resources :vinks

  root to: "site#index"

end