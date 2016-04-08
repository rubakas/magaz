class MagazCore::AdminServices::ProductImage::ChangeProductImage < ActiveInteraction::Base

  file    :image
  integer :id

  def execute
    product_image = MagazCore::ProductImage.find(id)

    unless product_image.update_attributes(inputs.slice!(:id))
      errors.merge!(product_image.errors)
    end
    
    product_image      
  end
end