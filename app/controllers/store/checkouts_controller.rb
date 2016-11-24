module Store
  class CheckoutsController < Store::ApplicationController
    # inherit_resources
    # actions :show, :update

    def update_address
      service = StoreServices::ShoppingCart::UpdateAddress.new(shop_id:       current_shop.id,
                                                               checkout_id:   session[:checkout_id],
                                                               customer_id:   session[:customer_id],
                                                               address_attrs: permitted_params_update_address[:checkout])
                                                           .run
      if service.success?
        redirect_to enter_payment_store_checkout_path(service.checkout)
      else
        render :show
      end
    end

    def enter_payment
      shopping_cart
    end

    def pay
      service = StoreServices::ShoppingCart::Pay.new(shop_id: current_shop.id,
                                                     checkout_id:   session[:checkout_id],
                                                     customer_id:   session[:customer_id],
                                                     order_attrs: permitted_params_order[:checkout])
                                                .run
      if service.success?
        redirect_to store_order_path(service.checkout)
      else
        render :enter_payment
      end
    end

    protected

    def permitted_params_update_address
      { checkout: params.fetch(:checkout, {}).permit(:email) }
    end

    def permitted_params_order
      { checkout: params.fetch(:checkout, {}).permit(:email) }
    end
  end
end
