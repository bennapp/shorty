Rails.application.routes.draw do
  get '*path', to: 'key#lookup'
end
