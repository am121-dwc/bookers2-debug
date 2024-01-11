Rails.application.routes.draw do
  get 'favorites/create'
  root to: 'homes#top'
  get 'home/about'
  devise_for :users
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorite, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
end