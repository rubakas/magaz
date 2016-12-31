class AdminServices::Product::DeleteProduct

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize  id:       nil,
                  shop_id:  nil
    @result = ::Shop
              .find(shop_id)
              .products
              .friendly
              .find(id)
  end

  def run
    @success = @result.destroy
    self
  end
end
