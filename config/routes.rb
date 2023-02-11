Rails.application.routes.draw do
  get 'posts/new', to: 'posts#new', as: 'new_post'
  post 'posts/new', to: 'posts#create', as: 'create_post'
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show] do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[create]
    end
  end
end
