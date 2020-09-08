Rails.application.routes.draw do
  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions'
  }

  devise_for :users

  namespace :staff do
    root to: "home#index"
  end

  get 'home/index'

  resources :branches
  resources :loans

  resources :books do
    member do
      get 'borrow', action: :borrow, as: :borrow
    end
  end

  root to: "home#index"
end
