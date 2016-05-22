class AdminServices::ProductImage::DeleteProductImage < ActiveInteraction::Base

  integer :id
  string :product_id

  validates :id, :product_id, presence: true

  def execute
    Product.friendly.find(product_id).product_images.find(id).destroy
  end

end