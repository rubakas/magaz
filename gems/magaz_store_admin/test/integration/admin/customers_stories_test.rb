module MagazStoreAdmin 
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
    fill_in 'First name', with: 'Some Uniq First Name'
    fill_in 'Last name', with: 'Some Uniq Last Name'
    fill_in 'Email', with: 'Some Uniq Email'
    click_button 'Create Customer'
    assert page.has_content? 'Customer was successfully created.'
  end

  test "edit сustomer" do
    click_link(@customer.email, match: :first)
    fill_in 'First name', with: 'Updated First Name'
    fill_in 'Last name', with: 'Updated Last Name'
    click_button 'Update Customer'
    assert page.has_content? 'Customer was successfully updated.'
  end

  test "import customers from csv" do
    attach_file('csv_file', File.join(Rails.root, 'test/fixtures/files/customers.csv'))
    click_button 'Import'
    assert page.has_content? 'test1customer@mail.com'
    assert page.has_content? 'test2customer@mail.com'
  end

  test "delete customer" do
    assert page.has_content? @customer.email
    click_link('Delete', match: :first)
    assert page.has_content? "No Customers"
  end
end
end
