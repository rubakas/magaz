class AdminServices::ProductImage::DeleteProductImage

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(id:, product_id:)
    @result = Product.friendly
              .find(product_id)
              .product_images
              .find(id)
  end

  def run
    @success = @result.destroy
    self
  end
end
