Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'

  get 'signup'  => 'users#new'
  get 'mytopbox' => 'folders#index'
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'home' => 'homes#new'

  resources :documents
  get 'home/new_document' => 'documents#new'
  get 'home/my_documents' => 'documents#index'

  resources :folders, :path => "mytopbox"

end
