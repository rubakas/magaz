class AdminServices::Checkout::ChangeOrder

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(id:, params:)
    @result = Checkout.find(id)
    @params = params
  end

  def run
    @success = @result.update_attributes(order_params)
    self
  end

  private

  def order_params
    @params.slice(:status)
  end
end
