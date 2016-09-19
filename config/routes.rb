Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper
  use_doorkeeper_openid_connect

  root 'example#index'
end
