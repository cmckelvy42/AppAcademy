Rails.application.routes.draw do
  resources :notes, only: [:create, :destroy]
  resources :tracks
  resources :albums do
    resources :tracks, only:[:new]
  end
  resources :bands do
    resources :albums, only:[:new]
  end
  resources :users
  resources :sessions, only:[:create]
  get 'logout', to: 'sessions#destroy'
  get 'login', to: 'sessions#new'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
