Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :artworks, only: [:create, :destroy, :show, :update] do
    resources :comments, only: [:index, :create, :destroy]
  end
  resources :users, only: [:create, :destroy, :index, :show, :update] do
    resources :artworks, only: [:index]
    resources :comments, only: [:index, :create, :destroy]
  end
  resources :artwork_shares, only: [:create, :destroy]
  
end
