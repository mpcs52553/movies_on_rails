Rails.application.routes.draw do

  get '/' => 'movies#index'

  resources :movies
  
end
