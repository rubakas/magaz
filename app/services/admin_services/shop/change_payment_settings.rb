class AdminServices::Shop::ChangePaymentSettings

  attr_reader :success, :shop, :errors
  alias_method :success?, :success

  def initialize id:, authorization_settings:
    @authorization_settings = authorization_settings
    @shop = Shop.find(id)
  end

  def run
    @shop.assign_attributes(authorization_settings: @authorization_settings)
    if @shop.valid?
      @shop.save
      @success = true
    else
      @errors = @shop.errors
      @success = false
    end
    self
  end
end
