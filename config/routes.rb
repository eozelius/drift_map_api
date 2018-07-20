Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :users, only: [:create, :show, :update, :destroy]
  resources :driftmaps, only: [:create, :update, :destroy]
end
