Rails.application.routes.draw do
  resources :notifications
  resources :privacies
  resources :permissions
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'

  get 'signup'  => 'users#new'
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :documents
  resources :folders, :path => 'mytopbox'
  resources :permissions

  get 'denied' => 'permissions#denied'

  get 'makeopen' => 'privacies#open'

  get 'shared' => 'folders#shared'

  get 'notifications' => 'notification#index'

  get 'documents/:id/visibility' => 'privacies#switch_visibility', :as => 'document_visibility'
  get 'documents/:id/download' => 'documents#download', :as => 'document_download'
  get 'documents/:id/gzip_compress' => 'documents#gzip_compress', :as => 'document_gzipcompress'

  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through


end
