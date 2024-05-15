Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get "home/about" => "homes#about", as: 'about'

  resources :posts, only: [:index, :create, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :update, :edit]
end