Bloodsugar::Application.routes.draw do
  resources :users
  resources :bg_measurements
  resources :sessions, only: [:new, :create, :destroy]
  get "update_location", :to => "bg_measurements#update_location"
  post "update_location", :to =>  "bg_measurements#update_location"
  root 'bg_measurements#index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
