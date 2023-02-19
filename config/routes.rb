Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root 'users#index'
  post 'comments/new', to: 'comments#create', as: 'create_comment'
  post 'likes/new', to: 'likes#create', as: 'create_like'
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create]
  end
end
