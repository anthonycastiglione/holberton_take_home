Rails.application.routes.draw do
  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions'
  }

  devise_for :users

  namespace :staff do
    root to: "home#index"
  end

  get 'home/index'

  resources :books
  resources :branches

  root to: "home#index"
end
