Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'games#index'
  resource :games, only: [:show, :create]
  resources :pieces
end
