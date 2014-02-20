VinkedIt::Application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

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

  get "/404", to: "errors#not_found"
  get "/403", to: "errors#not_authorized"
  get "/500", to: "errors#internal_server_error"

  root to: "site#index"

end
