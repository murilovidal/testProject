Rails.application.routes.draw do
  get 'home/index'
  get 'sessions/new'
  post 'login', to: 'sessions#create'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'home', to: 'home#index'
  get 'admin', to: 'home#admin_index'
  resources :news
  resources :users
  root 'welcome#index'

  
end
