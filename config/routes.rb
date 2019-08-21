Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  resource :games, only: [:show]
end
