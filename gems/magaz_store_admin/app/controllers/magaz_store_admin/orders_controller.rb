 module MagazStoreAdmin
  class OrdersController < ApplicationController
    include MagazCore::Concerns::Authenticable
    before_action :set_order, only: [:show, :update]


    def index
     @orders = current_shop.checkouts.orders.page(params[:page])
    end

    def show
      @order = current_shop.checkouts.orders.find(params[:id])
    end

    def update
      service = MagazCore::AdminServices::Checkout::ChangeOrder
                  .run(id: @order.id,
                       status: params[:order][:status])
      @order = service.order
      if service.valid?
        # @webhook_service = MagazCore::AdminServices::EventWebhookRunner.call(event: @event_service.event,
        #                                                                     topic: MagazCore::Webhook::Topics::UPDATE_ORDER_EVENT)
        flash[:notice] = t('.notice_success')
        redirect_to order_path(@order)
      else
        render 'show'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_shop.checkouts.orders.find(params[:id])
    end
  end
end
