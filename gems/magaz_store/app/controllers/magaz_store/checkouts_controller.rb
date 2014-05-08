module MagazStore
  class CheckoutsController < MagazStore::ApplicationController
    inherit_resources
    actions :show, :update

    def update_address
      if shopping_cart_service.update_address(permitted_params_update_address[:checkout])
        redirect_to enter_payment_checkout_path(resource)
      else
        render :show
      end
    end

    def enter_payment
      resource
    end

    def pay
      if shopping_cart_service.pay(permitted_params_pay[:checkout])
        redirect_to order_path(resource)
      else
        render :enter_payment
      end
    end

    protected

    def begin_of_association_chain
      current_shop
    end

    def resource
      shopping_cart_service.checkout
    end

    def permitted_params_update_address
      { checkout: params.fetch(:checkout, {}).permit(:email) }
    end

    def permitted_params_pay
      { checkout: params.fetch(:checkout, {}).permit(:email) }
    end
  end
end