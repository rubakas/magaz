require 'test_helper'

class MagazCore::AdminServices::Customer::AddCustomeromerTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @success_params = { first_name: "Test first name", last_name: "Test last name", email: "test@test.com", shop_id: @shop.id }
    @blank_params = { first_name: "", last_name: "", email: "", shop_id: nil}
  end

  test 'should create customer with valid params' do
    service = MagazCore::AdminServices::Customer::AddCustomer.run(@success_params)
    assert service.valid?
    assert MagazCore::Customer.find_by_id(service.result.id)
    assert_equal "Test first name", service.result.first_name
    assert_equal 1, @shop.customers.count
  end

  test 'should not create customer with same params' do
    service = MagazCore::AdminServices::Customer::AddCustomer.run(@success_params)
    assert service.valid?
    service2 = MagazCore::AdminServices::Customer::AddCustomer.run(@success_params)
    refute service2.valid?
    assert_equal 1, @shop.customers.count
    assert_equal 1, service2.errors.full_messages.count
    assert_equal "This customer is already exist in this shop", service2.errors.full_messages.last
  end

  test 'should not create customer with blank params' do
    service = MagazCore::AdminServices::Customer::AddCustomer.run(@blank_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal 0, @shop.customers.count
  end
end
