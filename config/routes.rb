Rails.application.routes.draw do
  resources :papers
  devise_for :users
  root 'home#index'
end
