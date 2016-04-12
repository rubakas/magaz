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
    MagazCore::Product.connection.transaction do
      begin
        @product = MagazCore::Product.new(inputs.slice!(:product_images_attributes))
        unless @product.save
          errors.merge!(@product.errors)
        end
        add_image_to_product if product_images_attributes["0"]
      rescue RuntimeError
        raise ActiveRecord::Rollback
      end
    end

    @product
  end

  private

  def name_uniqueness
    errors.add(:base, I18n.t('default.services.add_product.name_not_unique')) unless name_unique?
  end

  def name_unique?
    MagazCore::Product.where(shop_id: shop_id, name: name).count == 0
  end

  def add_image_to_product
    add_product_image_service =  MagazCore::AdminServices::ProductImage::AddProductImage
                                   .run(image: product_images_attributes["0"][:image],
                                        product_id: @product.id)
    unless add_product_image_service.valid?
      add_product_image_service.errors.full_messages.each do |msg|
        self.errors.add(:base, msg)
      end
      fail "Add product image service is not valid"
    end
  end

end
