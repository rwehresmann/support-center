Rails.application.routes.draw do
  root 'home#index'

  # Triggers authentication process with Auth0 Universal Login
  get 'auth/auth0', as: 'authentication'
  get 'auth/auth0/callback', to: 'auth0#callback'
  get 'auth/failure', to: 'auth0#failure'
end
