Rails.application.routes.draw do

  mount MagazStyle::Engine => "/style"

  constraints host: HOSTNAME do
    root 'welcome#index'
    get 'goodbye' => 'welcome#goodbye', as: :goodbye
    resource :registration, only: [:create, :show] do
      collection do
        post :validate
      end
    end
    resource :session, only: [:create, :destroy, :new, :show]
  end

  constraints(ShopSubdomainConstraint) do
    mount MagazStore::Engine => "/"
  #
  #   # mount MagazStoreAdmin::Engine => "/admin", :as => 'magaz_store_admin'
  #
    namespace :admin do
      root 'dashboard#index'
      resources :articles, except: [:edit]
      resources :blogs, except: [:edit]
      resources :checkouts, except: [:create, :edit, :new]
      resources :collections, except: [:edit]
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
      resources :webhooks, except: [:edit]
    end
  end

  get 'homepage'      => 'themes_store#homepage'
  get 'login'         => 'themes_store#login'
  get 'theme_page'    => 'themes_store#theme_page'
  get 'template_page' => 'themes_store#template_page'
  get 'learn_more'    => 'themes_store#learn_more'
  get 'demo'          => 'themes_store#demo'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
