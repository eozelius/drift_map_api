Rails.application.routes.draw do
  resources :users, only: [:create, :show, :update, :destroy]
  resources :driftmaps, only: [:create, :update, :destroy]

  post    'sessions'     => 'sessions#create'
  delete  'sessions/:id' => 'sessions#destroy'
end
