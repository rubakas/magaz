 module MagazStoreAdmin
  class OrdersController < ApplicationController
    include MagazCore::Concerns::Authenticable
    before_action :set_order, only: [:show, :update, :destroy]


    def index
     @orders = current_shop.checkouts.orders.page(params[:page])
    end

    def show
      @order = current_shop.checkouts.orders.find(params[:id])
    end

    def update
      service = MagazCore::AdminServices::Order::ChangeOrder
                  .run(id: @order.id,
                       status: params[:order][:status])
      if service.valid?
        @order = service.result
        # @webhook_service = MagazCore::AdminServices::EventWebhookRunner.call(event: @event_service.event,
        #                                                                     topic: MagazCore::Webhook::Topics::UPDATE_ORDER_EVENT)
        flash[:notice] = t('.notice_success')
        redirect_to order_path(@order)
      else
        @order = service
        render 'show'
      end
    end

    def destroy
      @order = current_shop.checkouts.orders.find(params[:id])
      @order.destroy
      # @webhook_service = MagazCore::AdminServices::EventWebhookRunner.call(event: @event_service.event,
      #                                                                     topic: MagazCore::Webhook::Topics::DELETE_ORDER_EVENT)
      flash[:notice] = t('.notice_success')
      render 'index'
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_shop.checkouts.orders.find(params[:id])
    end
  end
end
