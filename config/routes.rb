Rails.application.routes.draw do
  resources :papers, except: [:edit, :update, :delete]
  get 'papers/:id/approved', to: 'papers#approved', as: 'paper_approved'
  get 'papers/:id/disapproved', to: 'papers#disapproved', as: 'paper_disapproved'
  devise_for :users
  root 'home#index'
end
