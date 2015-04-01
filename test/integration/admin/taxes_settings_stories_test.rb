require 'test_helper'

class Admin::TaxesSettingsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    click_link "Settings"
    click_link "Taxes"
  end

  test "settings form" do
    assert page.has_content? 'Taxes'
  end

  test "update taxes settings" do
    check('shop_all_taxes_are_included')
    assert find('#shop_all_taxes_are_included').checked?
    check('shop_charge_taxes_on_shipping_rates')
    assert find('#shop_charge_taxes_on_shipping_rates').checked?

    #find('#shop_account_type_choice').first( 'option').select_option

    click_button 'Save'
    assert page.has_content? 'Shop was successfully updated.'
  end
end
