require 'test_helper'

class Admin::CountriesStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @country = create(:country, shop: @shop)
    @shipping_rate = create(:shipping_rate, country: @country)
    click_link 'Settings'
    click_link 'Shipping'
  end

  test "countries list" do
    assert page.has_content? 'Countries'
  end

  test "create country" do
    click_link 'Add Country'
    select('Finland', :from => 'country_code')
    fill_in 'Tax', with: '2'
    click_button 'Create Country'
    assert page.has_content? 'Country was successfully created.'
    assert page.has_content? 'Add Shipping Rates'
  end

  test "create country failure" do
    click_link 'Add Country'
    select('Ukraine', :from => 'country_code')
    fill_in 'Tax', with: ''
    click_button 'Create Country'
    assert page.has_content? '2 errors prohibited this country from being saved'
  end

  test "edit country" do
    click_link(@country.code, match: :first)
    select('Brazil', :from => 'country_code')
    click_button 'Update Country'
    assert page.has_content? 'Country was successfully updated.'
  end

  test "country has shipping rate" do
    click_link(@country.code, match: :first)
    assert page.has_content? @shipping_rate.name
  end

  test 'add shipping rate to country' do
    click_link(@country.code, match: :first)
    click_link 'Add Shipping Rates'
    fill_in 'Name', with: 'Uniq Rate Name'
    select('Based on order weight', :from => 'shipping_rate_criteria')
    fill_in 'shipping_rate_price_from', with: '1'
    fill_in 'shipping_rate_price_to', with: '3'
    click_button 'Create Shipping rate'
    assert page.has_content? 'Shipping rate was successfully created.'
    assert page.has_content? 'Editing Shipping Rate'
  end

  test 'delete link from link_list' do
    click_link(@country.code, match: :first)
    click_link "Delete"
    assert page.has_no_content? @shipping_rate.name
  end

  test 'update shipping rate' do
    click_link(@country.code, match: :first)
    click_link(@shipping_rate.name, match: :first)
    fill_in 'shipping_rate_price_from', with: '2'
    fill_in 'shipping_rate_price_to', with: '3'
    click_button 'Update Shipping rate'
    assert page.has_content? 'Shipping rate was successfully updated.'
    assert page.has_content? 'Editing Shipping Rate'
  end

  test "delete country" do
    assert page.has_content? @country.code
    click_link('Delete', match: :first)
    assert page.has_no_content? @country.code
  end
end