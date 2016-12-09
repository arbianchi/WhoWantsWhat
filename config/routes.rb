Rails.application.routes.draw do

    devise_for :users, controllers: {
        sessions: 'users/sessions'
    }

    root 'lists#index'

    resources :lists do
        resources :gifts
    end

    post '/claim/:id' => 'gifts#claim', as: :claim_gift
    delete '/claim/:id' => 'gifts#unclaim', as: :unclaim_gift

    delete '/my_gifts/:list_id/:gift_id' => 'gifts#delete_my_gift', as: :delete_my_gift

end
