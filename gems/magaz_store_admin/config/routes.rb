MagazStoreAdmin::Engine.routes.draw do

  #match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]


  constraints host: HOSTNAME do
    match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ], :as => '/404'
    get 'goodbye' => 'welcome#goodbye', as: :goodbye
  end

  root 'dashboard#index'
  resources :errors
  resources :articles, except: [:edit]
  resources :blogs, except: [:edit]
  resources :checkouts, except: [:create, :edit, :new]
  resources :collections, except: [:edit]
  resources :comments, except: [:edit]
  resources :shipping_countries, except: [:edit] do
    resources :shipping_rates
  end
  resources :customers, except: [:edit] do
    collection { post :import }
    collection { get  :export }
  end
  resources :files, except: [:edit]
  resources :tax_overrides, except: [:index]
  resources :link_lists, except: [:edit] do
    resources :links
  end
  resources :orders, except: [:create, :edit, :new]
  resources :pages, except: [:edit]
  resources :products, except: [:edit] do
    resources :product_images, except: [:edit]
  end
  resource  :session, only: [:create, :destroy, :new, :show]
  resource  :settings, only: [:edit, :update] do
    resources :email_templates, only: [:show, :edit, :update, :create]
    resources :subscriber_notifications, except: [:index, :show, :update] do
      member do
        get :send_test_notification
      end
    end
    put :checkouts_settings_update, :collection do
    end
    put :payments_settings_update, :collection do
    end
    put :notifications_settings_update, :collection do
    end
    put :taxes_settings_update, :collection do
    end
    get :enable_eu_digital_goods_vat_taxes, :collection do
    end
    put :save_default_collection, :collection do
    end
    member do
      get 'taxes_settings'
      get 'set_default_collection'
      get 'payments_settings'
      get 'checkouts_settings'
      get 'notifications_settings'
    end
  end
  resources :users, except: [:edit]
end
