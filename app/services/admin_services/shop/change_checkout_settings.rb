class AdminServices::Shop::ChangeCheckoutSettings

  attr_reader :success, :shop, :errors
  alias_method :success?, :success

  def initialize  id: nil,
                  checkouts_settings_params: {
                    'account_type_choice' => ::Shop::ACCOUNT_TYPE_CHOISE[::Shop::ACCOUNT_TYPE_CHOISE.index('disabled')],
                    'enable_multipass_login' => false,
                    'billing_address_is_shipping_too' => false,
                    'abandoned_checkout_time_delay' => ::Shop::ABANDONED_CHECKOUT_TIME_DELAY[::Shop::ABANDONED_CHECKOUT_TIME_DELAY.index('never')],
                    'email_marketing_choice' => ::Shop::EMAIL_MARKETING_CHOICE[::Shop::EMAIL_MARKETING_CHOICE.index('customer_agrees')],
                    'after_order_paid' => ::Shop::AFTER_ORDER_PAID[::Shop::AFTER_ORDER_PAID.index('automatically_fulfill')],
                    'notify_customers_of_their_shipment' => false,
                    'automatically_fulfill_all_orders' => false,
                    'after_order_fulfilled_and_paid' => false,
                    'checkout_refund_policy' => nil,
                    'checkout_privacy_policy' => nil,
                    'checkout_term_of_service' => nil
                  }
    @shop = Shop.find(id)
    @checkouts_settings_params = checkouts_settings_params
  end

  def run
    @shop.assign_attributes(@checkouts_settings_params)
    if @shop.valid?
      @success = true
      @shop.save
    else
      @errors = @shop.errors
      @success = false
    end
    self
  end
end
