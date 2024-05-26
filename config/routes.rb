Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get "home/about" => "homes#about", as: 'about'
  
  get "search", to: "searches#search"

  resources :posts, only: [:index, :show, :edit, :create, :destroy, :update] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :update, :edit] do
    resource :relationships, only: [:create, :destroy]
    get "followers" => "relationships#followers", as: "followers"
    get "following" => "relationships#following", as: "following"
  end
end