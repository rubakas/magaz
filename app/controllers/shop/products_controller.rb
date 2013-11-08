class Shop::ProductsController < Shop::ApplicationController
  def show
    @product = current_shop.products.find(params[:id])
  end
end
