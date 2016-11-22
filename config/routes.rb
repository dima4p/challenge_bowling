Rails.application.routes.draw do
  resources :games
  post '/score/:pins', to: 'games#score', as: 'score'

  root 'games#index'
end
