module Store
  class OrdersController < Store::ApplicationController

    def show
      @order = current_shop.checkouts.find(params[:id])
    end

  end
end
