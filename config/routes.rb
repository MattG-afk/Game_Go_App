Rails.application.routes.draw do

  root 'application#home'
  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  get '/signup' => 'users#new' 
  post '/signup' => 'users#create' 
  delete '/logout' => 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#omniauth'
  post 'games/:id/edit' => 'games#edit'

  resources :comments


  resources :users, only: [:show]

  resources :games do 
    resources :comments, only: [:new, :index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
