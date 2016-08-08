Rails.application.routes.draw do
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

  get 'default_create_doc' => 'documents#create_default_doc'
  get 'default_create_folder' => 'folders#create_default_folder'



end
