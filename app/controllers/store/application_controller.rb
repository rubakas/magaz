class Store::ApplicationController < ActionController::Base
  include CurrentShopAccess

  layout 'store'
  
  helper_method :shopping_cart

  around_action :set_shopping_cart

  def shopping_cart
    @shopping_cart
  end

  def set_shopping_cart
    @shopping_cart = if session[:cart_id].blank?
      current_shop.checkouts.create
    else
      existing_cart = current_shop.checkouts.not_orders.find_by_id(session[:cart_id])
      if existing_cart.blank?
        current_shop.checkouts.create
      else
        existing_cart
      end
    end
    session[:cart_id] = @shopping_cart.id

    yield
    
    @shopping_cart.save
  end
  
end
