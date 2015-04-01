 module MagazStoreAdmin
  class Admin::OrdersController < Admin::ApplicationController
    include MagazCore::Concerns::Authenticable
    before_action :set_order, only: [:show, :update, :destroy]


    def index
     @orders = current_shop.checkouts.orders.page(params[:page])
    end

    def show
      @order = current_shop.checkouts.orders.find(params[:id])
    end

    def update
      @order = current_shop.checkouts.orders.find(params[:id])
      if @order.update_attributes(permitted_params[:order])
        flash[:notice] = 'Order was successfully updated.'
        redirect_to admin_order_path(@order)
      else
        render 'show'
      end
    end

    def destroy
      @order = current_shop.checkouts.orders.find(params[:id])
      @order.destroy
      flash[:notice] = 'Order was successfully deleted.'
      render 'index'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_shop.checkouts.orders.find(params[:id])
    end

    protected

    #TODO:  collection_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { order:
          params.fetch(:product, {}).permit(:title, :content) }
    end
  end
end
