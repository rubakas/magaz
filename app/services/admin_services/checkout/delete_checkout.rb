class AdminServices::Checkout::DeleteCheckout

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(id:)
    @result = ::Checkout.find(id)
  end

  def run
    @success = @result.destroy
    self
  end
end
