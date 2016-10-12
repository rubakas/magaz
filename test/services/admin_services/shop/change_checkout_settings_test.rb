require 'test_helper'

class AdminServices::Shop::ChangeCheckoutSettingsTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @success_params = {id: @shop.id, checkouts_settings_params: {
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
                     }
  end

  test 'should update shop with valid success_params' do
    service = AdminServices::Shop::ChangeCheckoutSettings.new(@success_params).run
    assert service.success?
    refute service.shop.enable_multipass_login
    refute service.shop.billing_address_is_shipping_too
    refute service.shop.after_order_fulfilled_and_paid
    refute service.shop.notify_customers_of_their_shipment
    refute service.shop.automatically_fulfill_all_orders
    assert_equal 'customer_agrees', service.shop.email_marketing_choice
    assert_equal 'disabled', service.shop.account_type_choice
    assert_equal 'never', service.shop.abandoned_checkout_time_delay
    assert_equal 'automatically_fulfill', service.shop.after_order_paid
    assert_equal 'checkout_refund_policy', service.shop.checkout_refund_policy
    assert_equal 'checkout_privacy_policy', service.shop.checkout_privacy_policy
    assert_equal 'checkout_term_of_service', service.shop.checkout_term_of_service
  end

  test 'should update shop with valid blank params' do
    service = AdminServices::Shop::ChangeCheckoutSettings
              .new(id: @shop.id, checkouts_settings_params: {
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
                   checkout_term_of_service: ''})
                .run
    refute service.success?
    assert_equal 4, service.errors.count
    assert_includes service.errors.full_messages, "Account type choice is not included in the list"
    assert_includes service.errors.full_messages, "Abandoned checkout time delay is not included in the list"
    assert_includes service.errors.full_messages, "Email marketing choice is not included in the list"
    assert_includes service.errors.full_messages, "After order paid is not included in the list"
  end
end
