class MagazCore::AdminServices::ProductImage::DeleteProductImage < ActiveInteraction::Base

  integer :id, :product_id

  validates :id, :product_id, presence: true

  def execute
    MagazCore::Product.find(product_id).product_images.find(id).destroy
  end
end