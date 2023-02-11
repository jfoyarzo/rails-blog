Rails.application.routes.draw do
  root 'users#index'
  get 'posts/new', to: 'posts#new', as: 'new_post'
  post 'posts/new', to: 'posts#create', as: 'create_post'
  post 'comments/new', to: 'comments#create', as: 'create_comment'
  post 'likes/new', to: 'likes#create', as: 'create_like'
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show]
  end
end
