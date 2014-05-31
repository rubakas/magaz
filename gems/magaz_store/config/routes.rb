MagazStore::Engine.routes.draw do
  root 'welcome#index'
  resource :cart do
    collection do
      post :add
    end
  end

  resources :checkouts, only: [:show] do
    member do
      put :update_address
      get :enter_payment
      put :pay
    end
  end

  resources :orders, only: [:show]

  resources :products, only: [:show]
end
