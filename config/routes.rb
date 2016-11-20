Rails.application.routes.draw do
  get 'documents' => 'documents#index', as: :documents
  get 'documents/:id/finished' => 'documents#finished', as: :document_finished

  resources :papers, except: [:edit, :update, :delete]
  get 'papers/:id/approved', to: 'papers#approved', as: 'paper_approved'
  get 'papers/:id/disapproved', to: 'papers#disapproved', as: 'paper_disapproved'

  devise_for :users
  root 'home#index'
end
