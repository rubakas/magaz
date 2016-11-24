module Store
  class ProductsController < Store::ApplicationController
    def show
      @product = current_shop.products.friendly.find(params[:id])
    end
  end
end
