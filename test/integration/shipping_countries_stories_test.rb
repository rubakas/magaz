require 'test_helper'

class ShippingCountriesStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @shipping_country = create(:shipping_country, shop: @shop)
    @shipping_rate = create(:shipping_rate, shipping_country: @shipping_country)
    click_link 'Settings'
    click_link 'Shipping'
  end

  test "shipping countries list" do
    assert page.has_content? 'Shipping Countries'
  end

  test "create shipping country" do
    click_link 'Add Shipping Country'
    select('Finland', :from => 'shipping_country_name')
    fill_in 'Tax', with: '2'
    click_button 'Create Shipping country'
    assert page.has_content? 'Shipping Country was successfully created.'
    assert page.has_content? 'Add Shipping Rates'
  end

  test "create shipping country failure" do
    click_link 'Add Shipping Country'
    select('Finland', :from => 'shipping_country_name')
    fill_in 'Tax', with: ''
    click_button 'Create Shipping country'
    assert page.has_content? '2 errors prohibited this shipping country from being saved'
  end

  test "edit country" do
    click_link(@shipping_country.country_info['name'], match: :first)
    select('Poland', :from => 'shipping_country_name')
    click_button 'Update Shipping country'
    assert page.has_content? 'Shipping Country was successfully updated.'
  end

  test "shipping country has shipping rate" do
    click_link(@shipping_country.country_info['name'], match: :first)
    assert page.has_content? @shipping_rate.name
  end

  test 'add shipping rate to shipping country' do
    click_link(@shipping_country.country_info['name'], match: :first)
    click_link 'Add Shipping Rates'
    fill_in 'Name', with: 'Uniq Rate Name'
    select('Based on order price', :from => 'shipping_rate_criteria')
    fill_in 'shipping_rate_price_from', with: 1
    fill_in 'shipping_rate_price_to', with: 3
    fill_in 'Shipping price', with: 5
    click_button 'Create Shipping rate'
    assert page.has_content? 'Shipping rate was successfully created.'
    assert page.has_content? 'Editing Shipping Rate'
  end

  test 'delete shipping rate from shipping country' do
    click_link(@shipping_country.country_info['name'], match: :first)
    click_link "Delete"
    assert page.has_no_content? @shipping_country.country_info['name']
  end

  test 'update shipping rate' do
    click_link(@shipping_country.country_info['name'], match: :first)
    click_link(@shipping_rate.name, match: :first)
    select('Based on order price', :from => 'shipping_rate_criteria')
    fill_in 'shipping_rate_price_from', with: 2
    fill_in 'shipping_rate_price_to', with: 3
    click_button 'Update Shipping rate'
    assert page.has_content? 'Shipping rate was successfully updated.'
    assert page.has_content? 'Editing Shipping Rate'
  end

  test "delete shipping country" do
    assert page.has_content? @shipping_country.country_info['name']
    click_link('Delete', match: :first)
    assert page.has_no_content? @shipping_country.country_info['name']
  end
end