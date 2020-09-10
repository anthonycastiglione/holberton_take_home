Rails.application.routes.draw do
  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions'
  }

  devise_for :users

  namespace :staff do
    root to: "home#index"
  end

  get 'home/index'

  resources :branches do
    member do
      get 'update_branch', action: :update_branch, as: :update_branch
    end
  end
  resources :loans

  resources :books do
    member do
      get 'borrow', action: :borrow, as: :borrow
      get 'return', action: :return, as: :return
    end
  end

  root to: "home#index"
end
