Rails.application.routes.draw do
  resources :papers, except: [:edit, :update, :delete]
  devise_for :users
  root 'home#index'
end
