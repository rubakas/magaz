class AdminServices::Customer::ChangeCustomer

  attr_reader :success, :customer, :errors
  alias_method :success?, :success

  def initialize(id: nil, shop_id: nil, params: {'email' => nil, 'first_name' => nil, 'last_name' => nil})
    @shop_id = shop_id
    @customer = Shop.find(shop_id).customers.find(id)
    @params = params
  end

  def run
    @customer.assign_attributes(@params)
    if @customer.valid?
      @customer.save
      @success = true
    else
      @errors = @customer.errors
      @success = false
    end
    self
  end
end
