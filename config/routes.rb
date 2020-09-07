Rails.application.routes.draw do
  namespace :staff do
    get 'home/index'
  end
  devise_for :staffs
  devise_for :users

  namespace :staff do
    root to: "home#index"
  end

  get 'home/index'

  root to: "home#index"
end
