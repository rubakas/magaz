class MagazCore::AdminServices::ProductImage::AddProductImage < ActiveInteraction::Base

  set_callback :validate, :after, -> {product_image}

  file   :image
  string :product_id

  validates :product_id, :image, presence: true

  def product_image
    product = MagazCore::Product.friendly.find(product_id)
    @product_image = product.product_images.new
    add_errors if errors.any?
    @product_image
  end

  def execute
    unless @product_image.update_attributes(inputs.slice!(:product_id))
      errors.merge!(@product_image.errors)
    end
    @product_image
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @product_image.errors.add(:base, msg)
    end
  end

end
