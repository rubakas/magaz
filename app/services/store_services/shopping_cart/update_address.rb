class StoreServices::ShoppingCart::UpdateAddress

  attr_reader :success, :errors, :checkout
  alias_method :success?, :success

  def initialize(shop_id: nil, checkout_id: nil, customer_id: nil, address_attrs: nil)
    @shop     = Shop.find(shop_id)
    @customer = @shop.customers.find_by_id(customer_id) || @shop.customers.new
    @customer.save!(validate: false)
    @checkout = @customer.checkouts.not_orders.find_by_id(checkout_id) || @customer.checkouts.create
    @address_attrs = address_attrs
  end

  def run
    @checkout.assign_attributes(@address_attrs)
    if @checkout.valid?
      @checkout.save
      @success = true
    else
      @success = false
      @errors = @checkout.errors
    end
    self
  end
end
