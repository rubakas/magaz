require 'test_helper'

class Admin::CustomersStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @customer = create(:customer, shop: @shop)
    click_link 'Customers'
  end

  test "customers list" do
    assert page.has_content? 'Customers'
  end

  test "create сustomer" do
    click_link 'Add Customer'
    fill_in 'First Name', with: 'Some Uniq First Name'
    fill_in 'Last Name', with: 'Some Uniq Last Name'
    fill_in 'Email', with: 'Some Uniq Email'
    click_button 'Create Customer'
    assert page.has_content? 'Customer was successfully created'
  end
end