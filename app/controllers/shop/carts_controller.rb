class Shop::CartsController < Shop::ApplicationController

  def show
  end

  def add
    product_to_add = current_shop.products.find(params[:product_id])
    @shopping_cart.add_product(product: product_to_add, quantity: params[:quantity])
    render action: 'show'
  end
end
