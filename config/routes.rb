Rails.application.routes.draw do
  root to: 'pages#home'

  resources :uploads, only: [:new, :create]

  resources :merchants, only: [:index] do
    resources :items, only: [:index], controller: 'merchants/items' do
      resources :purchases, only: [:index], controller: 'merchants/items/purchases'
    end
  end

  devise_for :users
end
