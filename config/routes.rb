Rails.application.routes.draw do
  
  root 'sessions#new'  
  get 'messages/show'

  get 'friendships/create'

  get 'sessions/new'
  


  get 'users/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :passwordresets

  resources :users do
     resources :friendships do
     resources :messages
   end
end
end