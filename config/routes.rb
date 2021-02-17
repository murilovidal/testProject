Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles, :videos
  get '/admin', to: 'users#index', as: 'admin'
  get '/video/:id/comment', to: 'videos#comment', as: 'comment_video'
  post '/video/:id/comment', to: 'videos#save_comment', as: 'save_comment_video'
  match '/videocomment/', to: 'videos#destroy_comment', via: [:delete]
  match '/videocomment/:id', to: 'videos#destroy_comment', as: 'deletevideocomment', via: [:delete],
                             defaults: { format: 'js' }

  get '/article/:id/comment', to: 'articles#show_comment', as: 'comment_article'
  post '/article/:id/comment', to: 'articles#save_comment', as: 'save_comment_article'
  match '/articlecomment/:id', to: 'articles#destroy_comment', as: 'deletearticlecomment', via: [:delete],
                               defaults: { format: 'js' }
  match '/admin/users/:id', to: 'users#toggle_admin', via: [:post], as: 'toggleadmin', defaults: { format: 'js' }
end
