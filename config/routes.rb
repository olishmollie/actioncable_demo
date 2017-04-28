Rails.application.routes.draw do

  root to: "chatroom#show"
  resources :guests, :only => [:create, :index]
  delete "guests/destroy_all", to: "guests#destroy_all"

  mount ActionCable.server => '/cable'
end
