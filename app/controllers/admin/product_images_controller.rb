class Admin::ProductImagesController < Admin::ApplicationController
  include Concerns::Authenticable

  def index
    @product = current_shop.products.friendly.find(params[:product_id])
    @product_images = @product.product_images.page(params[:page])
  end

  def show
    @product = current_shop.products.friendly.find(params[:product_id])
    @product_image = @product.product_images.find(params[:id])
  end

  def new
    @product = current_shop.products.friendly.find(params[:product_id])
    @product_image = @product.product_images.new
  end

  def create
    service = AdminServices::ProductImage::AddProductImage
              .new(product_id: params[:product_id],
                   params: { image: set_image(params[:product_image]) })
              .run
    @product_image = service.result
    @product = @product_image.product
    if service.success?
      flash[:notice] = t('.notice_success')
      redirect_to admin_product_product_images_path
    else
      flash.now[:notice] = t('.notice_fail')
      render 'new'
    end
  end

  def update
    service = AdminServices::ProductImage::ChangeProductImage
              .new(id: params[:id],
                   product_id: params[:product_id],
                   params: { image: set_image(params[:product_image]) })
              .run
    @product_image = service.result
    @product = @product_image.product
    if service.success?
      flash.now[:notice] = t('.notice_success')
      render 'show'
    else
      flash.now[:notice] = t('.notice_fail')
      render 'show'
    end
  end

  def destroy
    AdminServices::ProductImage::DeleteProductImage
    .new(id: params[:id], product_id: params[:product_id])
    .run
    flash[:notice] = t('.notice_success')
    redirect_to admin_product_product_images_path
  end

  private

  def set_image(params)
    if params
      image = params[:image]
    else
      image = nil
    end
    image
  end
end
