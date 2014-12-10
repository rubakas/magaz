class Admin::ProductImagesController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable

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

  def update
    @product = current_shop.products.friendly.find(params[:product_id])
    @product_image = @product.product_images.find(params[:id])
    if @product_image.update_attributes(permitted_params[:product_image])
      flash[:notice] = 'Image was successfully updated.'
      render 'show'
    else
      render 'show'
    end
  end

  def create
    @product = current_shop.products.friendly.find(params[:product_id])
    @product_image = @product.product_images.new(permitted_params[:product_image])
    if @product_image.save
      flash[:notice] = 'Image was successfully created.'
      redirect_to admin_product_product_images_path
    else
      render 'show'
    end
  end


  def destroy
    @product = current_shop.products.friendly.find(params[:product_id])
    @product_image = @product.product_images.find(params[:id])
    @product_image.destroy
    flash[:notice] = 'Image was successfully deleted.'
    redirect_to admin_product_product_images_path
  end

  protected

  def permitted_params
    { product_image:
        params.fetch(:product_image, {}).permit(:image) }
  end
end
