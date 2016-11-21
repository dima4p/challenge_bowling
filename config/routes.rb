Rails.application.routes.draw do
  resources :games
  post '/score/:pins', to: 'games#score'

  root 'games#index'
end
