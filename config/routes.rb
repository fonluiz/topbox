Rails.application.routes.draw do
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


  get 'create_doc' => 'documents#create'
  get 'create_folder' => 'folders#create'



end
