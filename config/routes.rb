Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'games#index'
  resources :games#, only: [:show, :create, :update]
  resources :pieces
end
