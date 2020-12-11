Rails.application.routes.draw do
  get 'sessions/destroy'
  get 'sessions/new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'admin/index'

  get 'home', to: 'home#index'
  get 'admin', to: 'admin#index'


  resources :articles
  resources :videos
  resources :users

  
  root 'welcome#index'

  
end

