class AdminServices::Customer::DeleteCustomer

  attr_reader :success, :result
  alias_method :success?, :success

  def initialize(shop_id:, id:)
    @result = ::Shop.find(shop_id).customers.find(id)
  end

  def run
    @success = @result.destroy
    self
  end
end
