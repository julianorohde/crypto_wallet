Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :mining_types
  get 'welcome/index'#, to: 'welcome#index'
  get '/inicio', to: 'welcome#index'

  resources :coins
  #get '/coins', to: 'coins#index'   

  root to: 'welcome#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
