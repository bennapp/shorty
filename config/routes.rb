Rails.application.routes.draw do
  resources :lookups, only: [:create]
  get 'lookup/:token' => 'lookups#show'
  post 'lookups', to: 'lookups#create'
  root 'lookups#new'
  get '*path', to: 'lookups#lookup'
end
