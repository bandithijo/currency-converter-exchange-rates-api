Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'exchanges#index'
  post '', to: 'exchanges#index'
  get 'error', to: 'exchanges#error'
end
