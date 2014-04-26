class Store::ApplicationController < ActionController::Base
  include CurrentShopAccess
  
  class ActionView::LookupContext
    register_detail(:themes) {}
  end

  def _process_options(options)
    options[:themes] = current_shop.themes.installed.map
    super(options)
  end

  append_view_path Services::ThemeSystem::Resolver.instance

  layout 'store'
  
  around_action :run_shopping_cart_service
  helper_method :shopping_cart

  def shopping_cart_service
    @shopping_cart_service ||= 
      Services::ShoppingCart.new shop_id: current_shop.id, 
                                 checkout_id: session[:checkout_id], 
                                 customer_id: session[:customer_id]
  end

  def shopping_cart
    shopping_cart_service.checkout
  end

  def run_shopping_cart_service    
    shopping_cart_service
    
    session[:customer_id] = shopping_cart_service.customer.id
    session[:checkout_id] = shopping_cart_service.checkout.id

    yield

    shopping_cart_service.save_cart
  end
  
end
