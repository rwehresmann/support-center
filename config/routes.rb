Rails.application.routes.draw do
  namespace :admin do
    resources :users do
      post :login_as_user, on: :member
    end

    root to: 'users#index'
  end

  # Triggers authentication process with Auth0 Universal Login
  get 'auth/auth0', as: 'authentication'
  get 'auth/auth0/callback', to: 'auth0#callback'
  get 'auth/failure', to: 'auth0#failure'
  post '/auth/logout', to: 'auth0#logout'

  root 'home#index'
end
