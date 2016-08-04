class AdminServices::ProductImage::ChangeProductImage

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(id:, product_id:, params:)
    @result = Product.friendly.find(product_id).product_images.find(id)
    @params = params
  end

  def run
    @success = @result.update_attributes(product_image_params)
    self
  end

  private

  def product_image_params
    @params.slice(:image)
  end
end
