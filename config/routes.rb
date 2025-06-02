# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :producers, only: %i[index update create]
  get 'reports/index', to: 'reports#index', as: 'reports'
  resources :earrings
  resources :keys do
    member do
      get :check_associations
    end
  end
  # get 'dashboard/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'dashboard#index'
end
