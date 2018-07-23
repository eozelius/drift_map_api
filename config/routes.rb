Rails.application.routes.draw do
  resources :users, only: [:create, :show, :update, :destroy]
  resources :driftmaps, only: [:create, :update, :destroy]

  post '/login', to: 'user_token#create'
  post '/logout/:id', to: 'user_token#destroy'
end
