module MagazStoreAdmin
  class ProductImagesController < ApplicationController
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
      if params[:product_image]
        service = MagazCore::AdminServices::ProductImage::ChangeProductImage
                    .run(image: params[:product_image][:image], id: @product_image.id)
        if service.valid?
          @product_image = service.result
          flash[:notice] = t('.notice_success')
          render 'show'
        else
          service.errors.full_messages.each do |msg|
            @product_image.errors.add(:base, msg)
          end
          flash[:notice] = t('.notice_fail')
          render 'show'
        end
      else
        flash[:notice] = t('.notice_fail')
        render 'show'
      end
    end

    def create
      @product = current_shop.products.friendly.find(params[:product_id])
      service = MagazCore::AdminServices::ProductImage::AddProductImage
                  .run(image: params[:product_image][:image], product_id: @product.id)
      if service.valid?
        @product_image = service.result
        flash[:notice] = t('.notice_success')
        redirect_to product_product_images_path
      else
        @product_image = MagazCore::ProductImage.new
        service.errors.full_messages.each do |msg|
          @product_image.errors.add(:base, msg)
        end
        render 'show'
      end
    end


    def destroy
      @product = current_shop.products.friendly.find(params[:product_id])
      @product_image = @product.product_images.find(params[:id])
      @product_image.destroy
      flash[:notice] = t('.notice_success')
      redirect_to product_product_images_path
    end

    protected

    def permitted_params
      { product_image:
          params.fetch(:product_image, {}).permit(:image) }
    end
  end
end
