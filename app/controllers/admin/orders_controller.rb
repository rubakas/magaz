class Admin::OrdersController < Admin::ApplicationController
  include Concerns::Authenticable
  before_action :set_order, only: [:show, :update]


  def index
   @orders = current_shop.checkouts.orders.page(params[:page])
  end

  def show
    @order = current_shop.checkouts.orders.find(params[:id])
  end

  def update
    service = AdminServices::Checkout::ChangeOrder
              .new(id: @order.id, params: params[:order].permit!)
              .run
    @order = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_order_path(@order)
    else
      render 'show'
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = current_shop.checkouts.orders.find(params[:id])
  end
end
