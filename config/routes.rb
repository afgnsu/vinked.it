VinkedIt::Application.routes.draw do
  devise_for :users

  resources :users do
    get :profile
    resources :comments
  end
  resources :countries, except: [:show]
  resources :leagues, except: [:show]
  resources :clubs do
    resources :comments
  end
  resources :vinks do
    resources :comments
  end

  root to: "site#index"

end
