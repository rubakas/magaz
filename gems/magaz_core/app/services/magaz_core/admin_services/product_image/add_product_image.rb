class MagazCore::AdminServices::ProductImage::AddProductImage < ActiveInteraction::Base

  file :image
  integer :product_id

  def execute
    product_image = MagazCore::ProductImage.new(inputs)

    unless product_image.save
      errors.merge!(product_image.errors)
    end

    product_image
  end

end