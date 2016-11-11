module Store
  class CartsController < Store::ApplicationController
    def checkout
      render action: "checkout"
    end

    def update
      if params[:update] == 'update'
        service = StoreServices::ShoppingCart::CartUpdateWithHash.new(shop_id:     current_shop.id,
                                                                      checkout_id: session[:checkout_id],
                                                                      customer_id: session[:customer_id],
                                                                      id_qty_hash: params.permit![:cart][:updates])
                                                                  .run
        if service.success?
          redirect_to store_cart_path, notice: "Cart was successfully updated"
        else
          render action: "show"
        end
      elsif params[:checkout] == 'checkout'
        # redirect_to checkout_store_cart_path
        redirect_to checkout_path(shopping_cart_service.checkout)
      else
        #TODO:  notify
        render action: "show"
      end
    end

    def show
    end

    def add
      product_to_add = current_shop.products.find(permitted_params_for_add[:product_id])
      quantity =  if permitted_params_for_add[:quantity].blank?
                    1
                  else
                    permitted_params_for_add[:quantity].to_i
                  end
      StoreServices::ShoppingCart::AddProductToCart.new(shop_id:     current_shop.id,
                                                        checkout_id: session[:checkout_id],
                                                        customer_id: session[:customer_id],
                                                        product:     product_to_add,
                                                        quantity:    quantity)
                                                    .run
      redirect_to store_cart_path
    end

    def permitted_params_for_add
      params.permit(:product_id, :quantity)
    end
  end
end
