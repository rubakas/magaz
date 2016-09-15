module Store
  class OrdersController < Store::ApplicationController
    # inherit_resources
    # actions :show

    protected

    def begin_of_association_chain
      current_shop.checkouts
    end
  end
end
