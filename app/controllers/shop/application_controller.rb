class Shop::ApplicationController < ApplicationController
  layout 'shop'
  helper_method :shopping_cart

  def shopping_cart
    []
  end
  
end
