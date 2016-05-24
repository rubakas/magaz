require 'test_helper'

module Admin
  class TaxesSettingsStoriesTest < ActionDispatch::IntegrationTest
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
      click_button 'Save'
      assert page.has_content? 'Shop was successfully updated.'
    end

    test "should enable Digital Goods VAT taxes" do
      click_link "Enable"
      assert page.has_content? 'Charge eu digital goods vat taxes'
      assert find('#charge_vat_taxes').checked?
      assert page.has_content? 'Digital Goods VAT Tax'
      click_link "Digital Goods VAT Tax"
      assert page.has_content? 'Editing collection'

      click_link "Settings"
      click_link "Taxes"

      click_link "Choose an alternate collection"
      assert page.has_content? 'Update EU Digital Goods VAT Tax Rates Collection'
      click_button 'Save'
      assert page.has_content? "Taxes"
      click_button 'Save'
      assert page.has_content? 'Shop was successfully updated.'
    end

    test "should disble Digital VAT Taxes" do
      click_link "Enable"
      assert find('#charge_vat_taxes').checked?
      find('#charge_vat_taxes').set('false')
      click_button 'Save'
      assert page.has_content? 'Enable eu digital goods vat taxes'
    end
  end
end
