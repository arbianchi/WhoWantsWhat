Rails.application.routes.draw do

  devise_for :users

  root 'lists#index'

  resources :gifts
  post '/claim/:id' => 'gifts#claim', as: :claim_gift
  delete '/claim/:id' => 'gifts#unclaim', as: :unclaim_gift

  resources :lists
end
