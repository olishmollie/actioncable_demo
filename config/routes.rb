Rails.application.routes.draw do
  root to: "chatroom#show"

  resources :guests, :only => :create
end
