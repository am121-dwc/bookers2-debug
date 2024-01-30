Rails.application.routes.draw do
  get 'searches/search'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'favorites/create'
  root to: 'homes#top'
  get 'home/about'
  devise_for :users
  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
  resource :group_users, only: [:create, :destroy]
  get "new/mail" => "groups#new_mail"
  get "send/mail" => "groups#send_mail"
  end
  resources :chats, only: [:show, :create, :destroy]
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