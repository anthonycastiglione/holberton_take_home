Rails.application.routes.draw do
  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions'
  }

  devise_for :users

  namespace :staff do
    root to: "home#index"
  end

  get 'home/index'

  resources :books do
    member do
      get 'borrow', action: :borrow, as: :borrow
    end
  end
  resources :branches

  root to: "home#index"
end
