Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :productions
  resources :factors
  resources :ranks
  resources :models

  resources :users

  root to: 'productions#index'
end
