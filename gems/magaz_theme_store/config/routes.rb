MagazThemeStore::Engine.routes.draw do
  get 'themes/install'

  root 'themes#index'
  resources :themes do
    member do
      patch :install
    end
  end
end
