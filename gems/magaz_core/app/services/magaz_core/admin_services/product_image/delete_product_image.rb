class MagazCore::AdminServices::ProductImage::DeleteProductImage < ActiveInteraction::Base

  integer :id

  def execute
    MagazCore::ProductImage.find(id).destroy
  end
end