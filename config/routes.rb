Rails.application.routes.draw do
  root to: "chatroom#show"

  resources :guests, :only => :create
  delete "guests/destroy_all", to: "guests#destroy_all"
end
