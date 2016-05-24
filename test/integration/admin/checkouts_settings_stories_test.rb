require 'test_helper'

module Admin
  class CheckoutsSettingsStoriesTest < ActionDispatch::IntegrationTest
    setup do
      login
      click_link "Settings"
      click_link "Checkouts"
    end

    test "settings form" do
      assert page.has_content? 'Checkouts'
    end

    test "update checkouts settings" do
      assert_not page.has_css?('.js-checkouts_hidden_field_multipass')
      check('shop_billing_address_is_shipping_too')
      assert find('#shop_billing_address_is_shipping_too').checked?
      assert page.has_css?('.js-checkouts_hidden_field_auto_fulfill')
      find('#shop_account_type_choice').first( 'option').select_option
      find('#shop_abandoned_checkout_time_delay').first('option').select_option
      find('#shop_email_marketing_choice').first('option').select_option
      find('#shop_after_order_paid').first('option').select_option
      check('shop_after_order_fulfilled_and_paid')
      assert find('#shop_after_order_fulfilled_and_paid').checked?
      assert_not find('#shop_notify_customers_of_their_shipment').checked?
      assert_not find('#shop_automatically_fulfill_all_orders').checked?
      click_button 'Save'
      assert page.has_content? 'Shop was successfully updated.'
    end
  end
end