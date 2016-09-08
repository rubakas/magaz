require 'test_helper'

module Admin
  class PaymentsSettingsStoriesTest < ActionDispatch::IntegrationTest
    setup do
      login
      click_link "Settings"
      click_link "Payments"
    end

    test "settings form" do
      assert page.has_content? 'Payments'
    end

     test "update payments settings" do
      assert_not page.has_css?('.js-payments_hidden_field_authorize_and_charge')
      assert_not page.has_css?('.js-payments_hidden_field_authorize')
      assert page.has_css?('.field_with_select')
      find('#shop_authorization_settings').find_all('option')[2].select_option
      click_button 'Save'
      assert page.has_content? 'Shop was successfully updated.'
    end
  end
end
