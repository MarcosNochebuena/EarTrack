Rails.application.routes.draw do
  get 'reports/index', to: "reports#index", as: "reports"
  resources :earrings
  resources :keys
  #get 'dashboard/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#index"
end
