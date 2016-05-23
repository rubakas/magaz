namespace :admin do
  root 'dashboard#index'
  resources :articles, except: [:edit]
  resources :asset_files, except: [:edit]
  resources :blogs, except: [:edit]

  resources :checkouts, except: [:create, :edit, :new]
  resources :collections, except: [:edit]
  resources :customers, except: [:edit] do
    collection { post :import }
    collection { get  :export }
  end
  resources :link_lists, except: [:edit] do
    resources :links
  end

  resources :orders, except: [:create, :edit, :new]
  resources :pages, except: [:edit]
  resources :products, except: [:edit] do
    resources :product_images, except: [:edit]
  end


  resources :shipping_countries, except: [:edit] do
    resources :shipping_rates
  end
  
  resource  :session, only: [:create, :destroy, :new, :show]
  resource  :settings, only: [:edit, :update] do
    
    resources :email_templates, only: [:show, :edit, :update, :create]
    resources :subscriber_notifications, except: [:index, :show, :update] do
      member do
        get :send_test_notification
      end
    end

    collection do
      put :checkouts_settings_update
      put :enable_eu_digital_goods_vat_taxes
      put :notifications_settings_update
      put :payments_settings_update
      put :save_default_collection
      put :taxes_settings_update
    end
    
    member do
      get 'checkouts_settings'
      get 'notifications_settings'
      get 'payments_settings'
      get 'set_default_collection'
      get 'taxes_settings'
    end
  end
  
  resources :tax_overrides, except: [:index]
  resources :users, except: [:edit]
  resources :webhooks, except: [:edit]
end