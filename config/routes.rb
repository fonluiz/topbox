Rails.application.routes.draw do
  resources :notifications
  resources :privacies
  resources :permissions
  resources :users
  resources :documents
  resources :folders, :path => 'mytopbox'
  resources :permissions

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  #Login / Sign Up / Session
  root 'sessions#new'
  get 'signup'  => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  #recycle
  post "documents/:id/recycle" => "documents#recycle", as: :document_recycle
  post "documents/:id/trash" => "documents#move_to_trash", as: :document_move_to_trash
  post "folders/:id/recycle" => "folders#recycle", as: :folder_recycle
  post "folders/:id/trash" => "folders#move_to_trash", as: :folder_move_to_trash
  get "trash" => "folders#show_trash"
  post "trash/recycle" => "folders#recycle_all", as: :recycle_all
  post "trash/destroy_all" => "folders#trash_destroy_all", as: :trash_destroy_all




  get 'denied' => 'permissions#denied'
  get 'makeopen' => 'privacies#open'
  get 'shared' => 'folders#shared'
  get 'notifications' => 'notification#index'
  get 'documents/:id/visibility' => 'privacies#switch_visibility', :as => 'document_visibility'
  get 'documents/:id/download' => 'documents#download', :as => 'document_download'
  post 'documents/:id/compress' => 'documents#compress', :as => 'document_compress'
  post 'documents/:id/decompress' => 'documents#decompress', :as => 'document_decompress'

  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through

  post 'idiom_pt' => 'application#change_idiom_pt', :as => 'change_idiom_pt'
  post 'idiom_en' => 'application#change_idiom_en', :as => 'change_idiom_en'

end
