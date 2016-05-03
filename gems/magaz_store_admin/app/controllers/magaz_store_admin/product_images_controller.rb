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

    def create
      if params[:product_image]
        image = params[:product_image][:image]
      else
        image = nil
      end
      service = MagazCore::AdminServices::ProductImage::AddProductImage
                  .run(product_id: params[:product_id],
                       image: image)
      @product = service.product_image.product
      if service.valid?
        @product_image = service.result
        flash[:notice] = t('.notice_success')
        redirect_to product_product_images_path
      else
        @product_image = service.product_image
        flash.now[:notice] = t('.notice_fail')
        render 'new'
      end
    end

    def update
      if params[:product_image]
        image = params[:product_image][:image]
      else
        image = nil
      end
      service = MagazCore::AdminServices::ProductImage::ChangeProductImage
                  .run(product_id: params[:product_id],
                       image: params[:product_image][:image], id: params[:id])
      @product = service.product_image.product
      if service.valid?
        @product_image = service.result
        flash.now[:notice] = t('.notice_success')
        render 'show'
      else
        @product_image = service.product_image
        flash.now[:notice] = t('.notice_fail')
        render 'show'
      end
    end

    def destroy
      service = MagazCore::AdminServices::ProductImage::DeleteProductImage
                  .run(id: params[:id],
                       product_id: params[:product_id])
      flash[:notice] = t('.notice_success')
      redirect_to product_product_images_path
    end
    
  end
end
