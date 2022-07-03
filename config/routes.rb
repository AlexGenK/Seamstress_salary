Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :productions do
    resources :works do
      resources :executions
    end
  end
  resources :factors
  resources :ranks
  resources :surcharges

  resources :timesheets do
    resources :visits do
      get 'mass_new', on: :collection
      post 'mass_create', on: :collection
    end
  end
  
  resources :models do
    get 'recalculate', on: :member
    resources :operations do
      post 'filling', on: :collection
    end
  end

  resources :bonuses do
    resources :personals
  end

  resource :asort_bonus, controller: 'asort_bonus'
  resource :sreport, controller: 'sreport'
  resource :oreport, controller: 'oreport'

  resources :users

  root to: 'productions#index'
end
