Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => 'callbacks' }
  get '/users/auth/callback', to: 'callbacks#spotify'
  root to: 'pages#home'
  get '/users/auth/spotify/callback', to: 'pages#home'
  resources :playlists, only: [ :show, :create, :update ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
