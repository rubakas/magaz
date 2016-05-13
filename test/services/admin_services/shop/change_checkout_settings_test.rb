require 'test_helper'

class AdminServices::Shop::ChangeCheckoutSettingsTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @success_params = {id: @shop.id,
                       account_type_choice: 'disabled',
                       enable_multipass_login: '0',
                       billing_address_is_shipping_too: '0',
                       abandoned_checkout_time_delay: 'never',
                       email_marketing_choice: 'customer_agrees',
                       after_order_paid: 'automatically_fulfill',
                       notify_customers_of_their_shipment: '0',
                       automatically_fulfill_all_orders: '0',
                       after_order_fulfilled_and_paid: '0',
                       checkout_refund_policy: 'checkout_refund_policy',
                       checkout_privacy_policy: 'checkout_privacy_policy',
                       checkout_term_of_service: 'checkout_term_of_service'}
  end

  test 'should update shop with valid success_params' do
    service = AdminServices::Shop::ChangeCheckoutSettings.run(@success_params)
    assert service.valid?
    refute service.result.enable_multipass_login
    refute service.result.billing_address_is_shipping_too
    refute service.result.after_order_fulfilled_and_paid
    refute service.result.notify_customers_of_their_shipment
    refute service.result.automatically_fulfill_all_orders
    assert_equal 'customer_agrees', service.result.email_marketing_choice
    assert_equal 'disabled', service.result.account_type_choice
    assert_equal 'never', service.result.abandoned_checkout_time_delay
    assert_equal 'automatically_fulfill', service.result.after_order_paid
    assert_equal 'checkout_refund_policy', service.result.checkout_refund_policy
    assert_equal 'checkout_privacy_policy', service.result.checkout_privacy_policy
    assert_equal 'checkout_term_of_service', service.result.checkout_term_of_service
  end

  test 'should update shop with valid blank params' do
    service = AdminServices::Shop::ChangeCheckoutSettings
                .run(id: @shop.id,
                     account_type_choice: '',
                     enable_multipass_login: '',
                     billing_address_is_shipping_too: '',
                     abandoned_checkout_time_delay: '',
                     email_marketing_choice: '',
                     after_order_paid: '',
                     notify_customers_of_their_shipment: '',
                     automatically_fulfill_all_orders: '',
                     after_order_fulfilled_and_paid: '',
                     checkout_refund_policy: '',
                     checkout_privacy_policy: '',
                     checkout_term_of_service: '')
    refute service.valid?
    assert_equal 5, service.shop.errors.count
    assert_equal 'Billing address is shipping too is not a valid boolean',
                 service.shop.errors.full_messages[0]
    assert_equal 'Enable multipass login is not a valid boolean',
                 service.shop.errors.full_messages[1]
    assert_equal 'Notify customers of their shipment is not a valid boolean',
                 service.shop.errors.full_messages[2]
    assert_equal 'Automatically fulfill all orders is not a valid boolean',
                 service.shop.errors.full_messages[3]
    assert_equal 'After order fulfilled and paid is not a valid boolean',
                 service.shop.errors.full_messages[4]

  end
end
