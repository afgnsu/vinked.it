VinkedIt::Application.routes.draw do
  devise_for :users

  resources :users
  resources :countries, except: [:show]
  resources :leagues, except: [:show]
  resources :clubs
  resources :vinks

  root to: "site#index"

end