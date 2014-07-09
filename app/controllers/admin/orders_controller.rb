class Admin::OrdersController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable
  inherit_resources
  defaults :resource_class => MagazCore::Checkout, :collection_name => 'orders', :instance_name => 'order'
  before_action :set_order, only: [:show, :update, :destroy]

  def update
    update! do |success, failure|
      failure.html { render :show }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = current_shop.checkouts.orders.find(params[:id])
  end

  protected

  def begin_of_association_chain
    current_shop.checkouts.orders
  end

  def collection
    @orders ||= end_of_association_chain.page(params[:page])
  end

  def resource
    @order ||= end_of_association_chain.orders.find(params[:id])
  end

  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { order:
        params.fetch(:product, {}).permit(:title, :content) }
  end
end
