class AdminServices::Customer::DeleteCustomer

  attr_reader :success, :customer, :errors
  alias_method :success?, :success

  def initialize(shop_id: nil, id: nil)
    @customer = ::Shop.find(shop_id).customers.find(id)
  end

  def run
    @success = @customer.destroy
    @errors = @customer.errors
    self
  end
end
