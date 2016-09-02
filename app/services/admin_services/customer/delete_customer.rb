class AdminServices::Customer::DeleteCustomer

  attr_reader :success, :result, :errors
  alias_method :success?, :success

  def initialize(shop_id:, id:)
    @errors = []
    begin
      @result = ::Shop.find(shop_id).customers.find(id)
    rescue ActiveRecord::RecordNotFound => e
      @result = nil
      add_errors
    end
  end

  def run
    if @result != nil
      @success = @result.destroy
    end
    self
  end

  private

  def add_errors
    self.errors.push(I18n
                .t('services.delete_customer.record_not_found'))
  end
end
