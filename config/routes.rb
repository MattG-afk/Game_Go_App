Rails.application.routes.draw do

  get '/' => 'sessions#home'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new' 
  post '/signup' => 'users#create' 
  delete '/logout' => 'sessions#destroy'
  get '/auth/google_oauth2/callback' => 'sessions#omniauth'

  resources :comments

  resources :users, only: [:show]

  resources :games do 
    resources :comments, only: [:new, :index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
