require 'test_helper'

class StoreServices::ShoppingCart::PayTest < ActiveSupport::TestCase

  setup do
    @existing_shop      = create(:shop)
    @existing_customer  = create(:customer, shop:     @existing_shop)
    @existing_checkout 	= create(:checkout, customer: @existing_customer)
    @existing_product   = create(:product,  shop:     @existing_shop)
    @subscriber_notification = AdminServices::SubscriberNotification::AddSubscriberNotification
                               .new({ shop_id: @existing_shop.id, subscriber_notification_params: {
                                      notification_method: "email",
                                      subscription_address: "valid@email.com"}})
                               .run.subscriber_notification

    EmailTemplate::EMAIL_TEMPLATES.each do |template_type|
      @existing_shop.email_templates.create(template_type: template_type,
                                   name:          I18n.t("default.models.email_templates.#{template_type}.name"),
                                   title:         I18n.t("default.models.email_templates.#{template_type}.title"),
                                   body:          I18n.t("default.models.email_templates.#{template_type}.body"),
                                   description:   I18n.t("default.models.email_templates.#{template_type}.description"))
    end
  end

  test "should pay and send email with correct params" do
    ActionMailer::Base.deliveries = []
    service =  StoreServices::ShoppingCart::Pay
                .new(shop_id:     @existing_shop.id,
                     checkout_id: @existing_checkout.id,
                     customer_id: @existing_customer.id,
                     order_attrs: { email: "payed@mail.com" })
                .run
    assert service.success?
    assert_equal service.checkout, @existing_checkout
    assert_equal service.checkout.email, "payed@mail.com"
    assert_equal service.checkout.status, "open"
    assert_equal 1, ActionMailer::Base.deliveries.count
  end

  test "should not pay and not send email with invalid email" do
    ActionMailer::Base.deliveries = []
    service =  StoreServices::ShoppingCart::Pay
                .new(shop_id:     @existing_shop.id,
                     checkout_id: @existing_checkout.id,
                     customer_id: @existing_customer.id,
                     order_attrs: { email: "random" })
                .run
    refute service.success?
    assert_equal service.checkout, @existing_checkout
    assert_not_equal Checkout.find(service.checkout.id).email, "random"
    assert_equal 0, ActionMailer::Base.deliveries.count
  end

  test "should rise exeption with no params" do
    assert_raises ActiveRecord::RecordNotFound do
      StoreServices::ShoppingCart::Pay.new.run
    end
  end

end
