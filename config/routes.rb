Rails.application.routes.draw do
  root 'documents#index'

  scope path: '/documents', controller: :documents do
    post 'new' => :new, :as => :new_document
  end
  resources :documents, only: [:index, :create]
  resources :translations, only: :create
end
