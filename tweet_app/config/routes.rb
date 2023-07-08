Rails.application.routes.draw do
  post 'likes/:post_id/create' => 'likes#create'
  get 'likes/:post_id/create' => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'
  get 'likes/:post_id/destroy' => 'likes#destroy'

  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "logout" => "users#logout"

  get 'users/:id/likes' => 'users#likes'
  get 'users/index'
  get "users/:id" => "users#show"
  get "signup" => "users#new"
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  patch "users/:id/update" => "users#update"
  post "users/:id/update" => "users#update"

  get 'posts/index'
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  get "posts/:id/destroy" => "posts#destroy"

  get '/' => 'home#top'
  get "about" => "home#about"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
