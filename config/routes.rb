Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update] do
  # ——————————————— ここから ———————————————
  resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
  # ——————————— ここまでネストさせる ———————————
  end 

  resources :books, only: [:edit, :create, :index, :show, :update, :destroy] do
   resource :favorite, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  

  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
end