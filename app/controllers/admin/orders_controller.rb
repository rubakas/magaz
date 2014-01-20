class Admin::OrdersController < ApplicationController
  include Authenticable
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /admin/pages
  # GET /admin/pages.json
  def index
    @orders = current_shop.orders.page(params[:page])
  end

  # GET /admin/pages/1
  # GET /admin/pages/1.json
  def show
  end

  # GET /admin/pages/new
  def new
    @order = current_shop.orders.build
  end

  # POST /admin/pages
  # POST /admin/pages.json
  def create
    @order = current_shop.orders.build(order_params)

    if @order.save
      redirect_to [:admin, @order], notice: "Page was successfully created"
    else
      render action: "new"
    end
  end

  # PATCH/PUT /admin/pages/1
  # PATCH/PUT /admin/pages/1.json
  def update
    if @order.update(order_params)
      redirect_to [:admin, @order], notice: "Page was successfully updated"
    else
      render action: "show"
    end
  end

  # DELETE /admin/pages/1
  # DELETE /admin/pages/1.json
  def destroy
    @order.destroy
    redirect_to admin_pages_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_shop.orders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:title, :content)
    end
end
