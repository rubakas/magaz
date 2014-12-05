class Admin::ProductImagesController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable

  def index
    @product_images = current_shop.products.product_images.page(params[:page])
  end

  def show
    @product_image = current_shop.products.product_image.find(params[:id])
  end

  def new
    @product_image = current_shop.products.product_image.new
  end

  def create
    @product_image = current_shop.products.product_image.new(permitted_params[:product_image])
    if @product_image.save
      flash[:notice] = 'Image was successfully created.'
      redirect_to admin_product_image(@product_image)
    else
      render 'show'
    end
  end

  def update
    @product_image = current_shop.products.product_image.find(params[:id])
    if @product_image.update_attributes(permitted_params[:product_image])
      flash[:notice] = 'Image was successfully updated.'
      redirect_to admin_product_image(@product_image)
    else
      render 'show'
    end
  end

  def destroy
    @product_image = current_shop.products.product_image.find(params[:id])
    @product_image.destroy
    flash[:notice] = 'Image was successfully deleted.'
    render 'index'
  end 

  protected

  def permitted_params
    { product_image:
        params.fetch(:product_image, {}).permit(:image) }
  end
end
