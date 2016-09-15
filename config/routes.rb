Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper

  root 'example#index'
end
