class AdminServices::ProductImage::ChangeProductImage

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(id:, product_id:, params:)
    @result = Product.friendly.find(product_id).product_images.find(id)
    @params = params
  end

  def run
    @result.image = (@params['image'])
    @success = @result.save
    self
  end

  private

end
