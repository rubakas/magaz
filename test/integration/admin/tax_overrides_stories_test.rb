require 'test_helper'

class Admin::TaxOverridesStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @country = create(:country)
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shop.update_attributes(eu_digital_goods_collection_id: @collection.id)
    @shipping_country = create(:another_shipping_country, shop: @shop, country_id: @country.id)
    visit '/admin/settings/taxes_settings'
  end

  test "settings form" do
    assert page.has_content? 'Taxes'
  end

  test "should add new override for country" do
    assert page.has_content? @country.name
    click_link @country.name
    click_link "Add a tax override"
    assert page.has_content? "Add Tax Override for"
    assert page.has_content? @country.name
    page.choose('tax_override_is_shipping_false')
    page.find_by_id('tax_override_collection_id').find("option[value='#{@collection.id}']").select_option
    fill_in 'tax_override_rate', with: 12
    click_button 'Save'
    assert page.has_content? @collection.name
    assert page.has_content? 'Override was successfully created.'
  end

  test "should not add new override" do
    assert page.has_content? @country.name
    click_link @country.name
    click_link "Add a tax override"
    assert page.has_content? "Add Tax Override for"
    assert page.has_content? @country.name
    page.choose('tax_override_is_shipping_false')
    fill_in 'tax_override_rate', with: 12
    click_button 'Save'
    assert page.has_content? 'Creating of override was failed.'
  end

  test "should not add new override too" do
    assert page.has_content? @country.name
    click_link @country.name
    click_link "Add a tax override"
    assert page.has_content? "Add Tax Override for"
    assert page.has_content? @country.name
    page.choose('tax_override_is_shipping_false')
    fill_in 'tax_override_rate', with: ''
    click_button 'Save'
    assert page.has_content? 'Creating of override was failed.'
  end

  test "should add new override for country too" do
    assert page.has_content? @country.name
    click_link @country.name
    click_link "Add a tax override"
    assert page.has_content? "Add Tax Override for"
    assert page.has_content? @country.name
    page.choose('tax_override_is_shipping_true')
    fill_in 'tax_override_rate', with: 12
    click_button 'Save'
    assert page.has_content? 'Override was successfully created.'
  end
end