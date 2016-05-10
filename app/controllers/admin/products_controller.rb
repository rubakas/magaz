class Admin::ProductsController < Admin::ApplicationController
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
    service = MagazCore::AdminServices::Product::AddProduct
                .run(shop_id: current_shop.id,
                     name: params[:product][:name],
                     handle: params[:product][:handle],
                     price: params[:product][:price].to_f,
                     page_title: params[:product][:page_title],
                     description: params[:product][:description],
                     collection_ids: params[:product][:collection_ids],
                     meta_description:params[:product][:meta_description],
                     product_images_attributes: params[:product][:product_images_attributes])
    if service.valid?
      @product = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_product_path(@product)
    else
      @product = MagazCore::Product.new
      service.errors.full_messages.each do |msg|
        @product.errors.add(:base, msg)
      end
      flash.now[:notice] = t('.notice_fail')
      render 'new'
       # @webhook_service = MagazCore::AdminServices::EventWebhookRunner.call(event: @event_service.event,
       #                                                                     topic: MagazCore::Webhook::Topics::CREATE_PRODUCT_EVENT)
    end
  end

  def update
    @product = current_shop.products.friendly.find(params[:id])
    if @product.update_attributes(permitted_params[:product])
      # @webhook_service = MagazCore::AdminServices::EventWebhookRunner.call(event: @event_service.event,
      #                                                                     topic: MagazCore::Webhook::Topics::UPDATE_PRODUCT_EVENT)
      flash[:notice] = t('.notice_success')
      redirect_to admin_product_path(@product)
    else
      render 'show'
    end
  end

  def destroy
    @product = current_shop.products.friendly.find(params[:id])
    @product.destroy
    # @webhook_service = MagazCore::AdminServices::EventWebhookRunner.call(event: @event_service.event,
    #                                                                     topic: MagazCore::Webhook::Topics::DELETE_PRODUCT_EVENT)
    flash[:notice] = t('.notice_success')
    redirect_to admin_products_path
  end

  protected
  #TODO:  collection_ids are not guaranteed to belong to this shop!!!
  # https://github.com/josevalim/inherited_resources#strong-parameters
  def permitted_params
    { product:
        params.fetch(:product, {}).permit(:name, :description, :price,
         :page_title, :meta_description, :handle,
         product_images_attributes: [:image, :_destroy, :id], collection_ids: []) }
  end
end
