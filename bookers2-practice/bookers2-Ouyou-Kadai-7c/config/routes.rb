Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  get "search" => "searches#search"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    # member do
    #   get :follows, :followers
    # end
    # resource :relationships, only: [:create, :destroy]

    resource :relationships, only: [:create, :destroy]
    get "followinfs" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end

  resources :groups, only: [:new, :index, :show, :create, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
