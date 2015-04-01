MagazStoreAdmin::Engine.routes.draw do

  namespace :admin do
    root 'dashboard#index'
    resource  :session, only: [:create, :destroy, :new, :show]
  end
end
