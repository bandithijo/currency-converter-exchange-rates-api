Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'exchanges#index'

  namespace :exchange do
    resources :one, only: [:index, :error]
    post '/one', to: 'one#index'
    resources :two, only: [:index, :error]
    post '/two', to: 'two#index'
    resources :three, only: [:index, :error]
    post '/three', to: 'three#index'
    resources :four, only: [:index, :error]
    post '/four', to: 'four#index'
  end

  get 'error', to: 'exchanges#error'
end
