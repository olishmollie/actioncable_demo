Rails.application.routes.draw do

  root to: "chatroom#show"
  resources :guests, :only => :create

  mount ActionCable.server => '/cable'
end
