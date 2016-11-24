module Store
  class ApplicationController < ActionController::Base
    include Concerns::CurrentShopAccess
    include Concerns::Themed

    layout 'store/store'

    around_action :run_shopping_cart_service
    helper_method :shopping_cart

    def shopping_cart
      @checkout
    end

    def run_shopping_cart_service
      @shop     = current_shop
      @customer = @shop.customers.find_by_id(session[:customer_id]) || @shop.customers.new
      @customer.save!(validate: false)
      @checkout = @customer.checkouts.not_orders.find_by_id(session[:checkout_id]) || @customer.checkouts.create

      session[:customer_id] = @customer.id
      session[:checkout_id] = @checkout.id

      yield

      @checkout.save
    end

  end
end
