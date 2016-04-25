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
          flash.now[:notice] = t('.notice_success')
          render 'show'
        else
          service.errors.full_messages.each do |msg|
            @product_image.errors.add(:base, msg)
          end
          flash.now[:notice] = t('.notice_fail')
          render 'show'
        end
      else
        @product_image.errors.add(:base, I18n.t('services.change_product_image.no_image'))
        flash.now[:notice] = t('.notice_fail')
        render 'show'
      end
    end

    def create
      @product = current_shop.products.friendly.find(params[:product_id])
      if params[:product_image]
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
          flash.now[:notice] = t('.notice_fail')
          render 'show'
        end
      else
        @product_image = MagazCore::ProductImage.new
        @product_image.errors.add(:base, I18n.t('services.add_product_image.no_image'))
        flash.now[:notice] = t('.notice_fail')
        render 'show'
      end
    end

    def destroy
      service = MagazCore::AdminServices::ProductImage::DeleteProductImage
                  .run(id: params[:id], product_id: params[:product_id])
      flash[:notice] = t('.notice_success')
      redirect_to product_product_images_path
    end
  end
end
