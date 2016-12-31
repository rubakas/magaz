class StoreServices::ShoppingCart::Pay

  attr_reader :success, :errors, :checkout
  alias_method :success?, :success

  def initialize  shop_id: nil,
                  checkout_id: nil,
                  customer_id: nil,
                  order_attrs: nil
                  
    @shop     = Shop.find(shop_id)
    @customer = @shop.customers.find_by_id(customer_id) || @shop.customers.new
    @customer.save!(validate: false)
    @checkout = @customer.checkouts.not_orders.find_by_id(checkout_id) || @customer.checkouts.create
    @order_attrs = order_attrs
  end

  def run
    #TODO:  connect with payment processor, pay method
    #TODO: why the fuck status is not from constant
    attrs = { 'status' => I18n.t('default.models.shopping_cart.open') }.merge @order_attrs
    @checkout.assign_attributes(attrs)
    if @checkout.valid?
      @checkout.save
      _send_email
      @success = true
    else
      @success = false
      @errors = @checkout.errors
    end
    self
  end

  private

  def _send_email
    email_template = @shop.email_templates.find_by(template_type: 'new_order_notification')
    @shop.subscriber_notifications.each do |s|
      UserMailer.notification(s, email_template).deliver_now
    end
  end

end
