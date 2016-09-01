class AdminServices::Customer::AddCustomer

  attr_reader :success, :result, :errors
  alias_method :success?, :success

  def initialize(shop_id:, params:)
    @shop_id = shop_id
    @result = Shop.find(shop_id).customers.new
    @params = params
    @errors = []
  end

  def run
    @result.attributes = customer_params
    customer_uniquness
    if @result.errors.present?
      @succes = false
    else
      @success = @result.save
    end
    self
  end

  private

  def customer_params
    @params.slice(:first_name, :last_name, :email)
  end

  def customer_uniquness
    @result.errors.add(:base, I18n
                .t('services.add_customer.customer_exist')) unless customer_unique?
  end

  def customer_unique?
    Customer.where(shop_id: @shop_id, email: customer_params[:email]).count == 0
  end

end
