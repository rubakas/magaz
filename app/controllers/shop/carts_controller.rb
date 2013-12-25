class Shop::CartsController < Shop::ApplicationController
  def checkout
    render action: "checkout"
  end

  def update
    if params[:update] == 'update'
      if @shopping_cart.update(params[:cart][:updates])
        redirect_to shop_cart_path, notice: "Cart was successfully updated"
      else
        render action: "show"
      end
    elsif params[:checkout] == 'checkout'
      redirect_to checkout_shop_cart_path
    else
      #TODO notify
      render action: "show"
    end
  end

  def show
  end

  def add
    product_to_add = current_shop.products.find(params[:product_id])
    params[:quantity] = 1 if params[:quantity].blank?
    @shopping_cart.add_product(product: product_to_add, quantity: params[:quantity])
    render action: 'show'
  end
end
