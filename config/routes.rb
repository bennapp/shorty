Rails.application.routes.draw do
  resources :lookups
  get '*path', to: 'lookups#lookup'
end
