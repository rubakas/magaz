module MagazStore
  class OrdersController < MagazStore::ApplicationController
    inherit_resources
    actions :show

    protected

    def begin_of_association_chain
      current_shop.checkouts
    end
  end
end