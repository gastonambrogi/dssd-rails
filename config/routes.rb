Rails.application.routes.draw do
  get 'schedule' => 'scheduler#index', as: :scheduler_index
  get 'schedule/:id' => 'scheduler#schedule', as: :schedule
  get 'scheduled' => 'scheduler#scheduled', as: :scheduled

  get 'documents' => 'documents#index', as: :documents
  get 'documents/:id/finish' => 'documents#finished', as: :document_finished

  resources :papers, except: [:edit, :update, :delete]
  get 'papers/:id/approved', to: 'papers#approved', as: :paper_approved
  get 'papers/:id/disapproved', to: 'papers#disapproved', as: :paper_disapproved

  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'home#index'
end
