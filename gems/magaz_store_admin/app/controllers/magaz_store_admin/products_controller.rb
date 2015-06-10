module MagazStoreAdmin
  class ProductsController < ApplicationController
    include MagazCore::Concerns::Authenticable

    def index
      @products = current_shop.products.page(params[:page])
    end

    def show
      @product = current_shop.products.friendly.find(params[:id])
    end

    def new
      @product = current_shop.products.new
    end

    def create
      @shop = current_shop
      @product = @shop.products.new(permitted_params[:product])
      if @product.save
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @product,
                                                                   topic: MagazCore::Webhook::Topics::CREATE_PRODUCT_EVENT,
                                                                   current_user: current_user)
        @webhook_service = MagazCore::ShopServices::EventWebhookRunner.call(event: @event_service.event,
                                                                            topic: MagazCore::Webhook::Topics::CREATE_PRODUCT_EVENT)
        flash[:notice] = t('.notice_success')
        redirect_to product_path(@product)
      else
        render 'show'
      end
    end

    def update
      @product = current_shop.products.friendly.find(params[:id])
      if @product.update_attributes(permitted_params[:product])
        @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @product,
                                                                   topic: MagazCore::Webhook::Topics::UPDATE_PRODUCT_EVENT,
                                                                   current_user: current_user)
        @webhook_service = MagazCore::ShopServices::EventWebhookRunner.call(event: @event_service.event,
                                                                            topic: MagazCore::Webhook::Topics::UPDATE_PRODUCT_EVENT)
        flash[:notice] = t('.notice_success')
        redirect_to product_path(@product)
      else
        render 'show'
      end
    end

    def destroy
      @product = current_shop.products.friendly.find(params[:id])
      @product.destroy
      @event_service = MagazCore::ShopServices::CreateEvent.call(subject: @product,
                                                                 topic: MagazCore::Webhook::Topics::DELETE_PRODUCT_EVENT,
                                                                 current_user: current_user)
      @webhook_service = MagazCore::ShopServices::EventWebhookRunner.call(event: @event_service.event,
                                                                          topic: MagazCore::Webhook::Topics::DELETE_PRODUCT_EVENT)
      flash[:notice] = t('.notice_success')
      redirect_to products_path
    end

    protected
    #TODO:  collection_ids are not guaranteed to belong to this shop!!!
    # https://github.com/josevalim/inherited_resources#strong-parameters
    def permitted_params
      { product:
          params.fetch(:product, {}).permit(:name, :description, :price, :page_title, :meta_description, :handle, product_images_attributes: [:image, :_destroy, :id], collection_ids: []) }
    end
  end
end
