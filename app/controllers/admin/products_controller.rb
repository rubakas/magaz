class Admin::ProductsController < Admin::ApplicationController
  include Concerns::Authenticable

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
    service = AdminServices::Product::AddProduct
              .new(shop_id: current_shop.id, params: params[:product].permit!)
              .run
    @product = service.result
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_product_path(@product)
    else
      # TODO : ASK ABOUT THIS
      # @product = Product.new
      # service.errors.full_messages.each do |msg|
      #   @product.errors.add(:base, msg)
      # end
      flash.now[:notice] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::Product::ChangeProduct
                                      .new(id: params[:id],
                                           shop_id: current_shop.id,
                                           params: permitted_params[:product])
                                      .run
    if service.success?
      @product = service.result
      flash[:notice] = t('.notice_success')
      redirect_to admin_product_path(@product)
    else
      @product = service
      render 'show'
    end
  end

  def destroy
    service = AdminServices::Product::DeleteProduct
              .new(id: params[:id], shop_id: current_shop.id)
              .run
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
