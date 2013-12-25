class Shop::ApplicationController < ApplicationController
  layout 'shop'
  helper_method :shopping_cart

  around_action :set_shopping_cart

  def shopping_cart
    @shopping_cart
  end

  def set_shopping_cart
    session[:cart] = Cart.new if session[:cart].blank?
    @shopping_cart = session[:cart]
    yield
    session[:cart] = @shopping_cart
  end
  
end
