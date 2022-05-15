Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :productions
  resources :factors
  resources :ranks
  resources :timesheets
  resources :models do
    resources :operations do
      post 'filling', on: :collection
    end
  end

  resources :users

  root to: 'productions#index'
end
