class MagazCore::AdminServices::Product::AddProduct < ActiveInteraction::Base

  string  :name
  integer :shop_id
  string  :description, :handle, :page_title, :meta_description, default: nil
  array   :collection_ids, default: nil
  decimal :price, default: nil
  hash    :product_images_attributes, strip: false, default: {}

  validates :name, :shop_id, presence: true
  validate :name_uniqueness

  def execute
    @product = MagazCore::Product.new
    should_rollback = true

    MagazCore::Product.connection.transaction do
      begin

        @product.attributes = inputs.slice!(:product_images_attributes)

        unless @product.save
          errors.merge!(@product.errors)
        end

        catch(:interrupt) do
          compose(MagazCore::AdminServices::ProductImage::AddProductImage,
                  image: product_images_attributes["0"][:image],
                  product_id: @product.id) if product_images_attributes["0"]
          should_rollback = false
        end
        raise RuntimeError.new if should_rollback

      rescue RuntimeError
        raise ActiveRecord::Rollback
      end
    end
    throw :interrupt if should_rollback
    @product
  end

  private

  def name_uniqueness
    errors.add(:base, I18n.t('services.add_product.name_not_unique')) unless name_unique?
  end

  def name_unique?
    MagazCore::Product.where(shop_id: shop_id, name: name).count == 0
  end

end
