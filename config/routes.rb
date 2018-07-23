Rails.application.routes.draw do
  resources :users, only: [:create, :show, :update, :destroy]
  resources :driftmaps, only: [:create, :update, :destroy]
end
