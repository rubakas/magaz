class AdminServices::Shop::ChangeShop

  attr_reader :success, :shop, :errors
  alias_method :success?, :success

  def initialize(id: current_shop.id, shop_params: {
                 name: nil,
                 business_name: nil,
                 city: nil,
                 country: nil,
                 currency: nil,
                 customer_email: nil,
                 phone: nil,
                 timezone: nil,
                 unit_system: nil,
                 zip: nil,
                 page_title: nil,
                 meta_description: nil,
                 address: nil }
                )
    @shop = Shop.find(id)
    @shop_params = shop_params
  end

  def run
    @shop.assign_attributes(@shop_params)
    if @shop.valid?
      @shop.save
      @success = true
    else
      @success = false
      @errors = @shop.errors
    end
    self
  end

end
