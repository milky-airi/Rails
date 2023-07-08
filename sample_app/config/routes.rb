Rails.application.routes.draw do

  get '/top' => 'homes#top'
  resources :lists
  get "lists/:id/destroy" => "lists#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
