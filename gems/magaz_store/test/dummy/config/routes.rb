Rails.application.routes.draw do

  mount MagazStore::Engine, at: '/', as: :magaz_store
  
end
