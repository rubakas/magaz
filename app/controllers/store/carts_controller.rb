class Store::CartsController < Store::ApplicationController
  def checkout
    render action: "checkout"
  end

  def update
    if params[:update] == 'update'
      if shopping_cart_service.update_with_hash(params.permit![:cart][:updates])
        redirect_to store_cart_path, notice: "Cart was successfully updated"
      else
        render action: "show"
      end
    elsif params[:checkout] == 'checkout'
      # redirect_to checkout_store_cart_path
      redirect_to store_checkout_path(@shopping_cart)
    else
      #TODO notify
      render action: "show"
    end
  end

  def show
  end

  def add
    product_to_add = current_shop.products.find(permitted_params_for_add[:product_id])
    quantity = if permitted_params_for_add[:quantity].blank?
      1
    else
      permitted_params_for_add[:quantity].to_i
    end
    shopping_cart_service.add_product(product: product_to_add, quantity: quantity)
    redirect_to store_cart_path
  end

  def permitted_params_for_add
    params.permit(:product_id, :quantity)
  end
end
