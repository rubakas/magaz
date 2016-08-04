class AdminServices::ProductImage::AddProductImage

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(product_id:, params:)
    @result = Product.friendly.find(product_id).product_images.new
    @params = params
  end

  def run
    @result.attributes = product_image_params
    @success = @result.save
    self
  end

  private

  def product_image_params
    @params.slice(:image)
  end
end
