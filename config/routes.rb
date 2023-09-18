Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static_pages#top'
  
  
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
  
  resources :users, only: %i[new create index]

  resources :boards, only: %i[new create index show destroy] do
    resources :comments,shallow: true 
  end
  
end
