Rails.application.routes.draw do
  get 'searches/search'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'favorites/create'
  root to: 'homes#top'
  get 'home/about'
  devise_for :users
  resources :groups, only: [:new, :index, :show, :create, :edit, :update]
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
  end
end