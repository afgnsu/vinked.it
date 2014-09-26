VinkedIt::Application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  namespace :api do
    api version: 1, module: 'v1' do
      resources :sessions, only: [:create]
      resources :vinks, only: [:index]
    end
  end
  
  resources :users do
    get :profile
    get :statistics
    get :map
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

  get "site/faq"
  get "/404", to: "errors#not_found"
  get "/403", to: "errors#not_authorized"
  get "/500", to: "errors#internal_server_error"

  root to: "site#index"

end
