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
      @order = current_shop.checkouts.orders.find(params[:id])
      if @order.update_attributes(permitted_params[:order])
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @order,
                                                                   message: I18n.t('magaz_store_admin.events.message', action: t('.updated'), subject: t('.order'), user_name: full_name(user: current_user)),
                                                                   verb: t('.update'),
                                                                   webhook: MagazCore::Event::Roles::UPDATE_ORDER_EVENT)
        flash[:notice] = t('.notice_success')
        redirect_to order_path(@order)
      else
        render 'show'
      end
    end

    def destroy
      @order = current_shop.checkouts.orders.find(params[:id])
      @order.destroy
      @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @order,
                                                                 message: I18n.t('magaz_store_admin.events.message', action: t('.deleted'), subject: t('.order'), user_name: full_name(user: current_user)),
                                                                 verb: t('.destroy'),
                                                                 webhook: MagazCore::Event::Roles::DELETE_ORDER_EVENT)
      flash[:notice] = t('.notice_success')
      render 'index'
    end

    private

    def full_name(user:)
      [user.first_name, user.last_name].map(&:capitalize).join(" ")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_shop.checkouts.orders.find(params[:id])
    end

    protected

    #TODO:  order_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { order:
          params.fetch(:product, {}).permit(:title, :content) }
    end
  end
end
