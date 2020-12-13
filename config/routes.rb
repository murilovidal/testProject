Rails.application.routes.draw do
  get 'sessions/destroy'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'admin/index'

  get 'home', to: 'home#index'
  get 'admin', to: 'admin#index'
  
  get '/articles/:id/comment', to: 'articles#comment', as: 'comment_article'
  post '/articles/:id/comment', to: 'articles#save_comment', as: 'save_comment_article'
  
  get '/videos/:id/comment', to: 'videos#comment', as: 'comment_video'
  post '/videos/:id/comment', to: 'videos#save_comment', as: 'save_comment_video'

  resources :articles
  resources :videos
  resources :users
  
  root 'welcome#index'

end

