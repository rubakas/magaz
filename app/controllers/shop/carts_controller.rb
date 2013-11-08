class Shop::CartsController < Shop::ApplicationController

  def show
  end

  def add
    product_to_add = current_shop.products.find(params[:product_id])
    shopping_cart << product_to_add if product_to_add
    render action: 'show'
  end
end
