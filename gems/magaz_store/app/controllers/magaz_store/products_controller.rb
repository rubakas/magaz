module MagazStore
  class ProductsController < MagazStore::ApplicationController
    def show
      @product = current_shop.products.find(params[:id])
    end
  end
end