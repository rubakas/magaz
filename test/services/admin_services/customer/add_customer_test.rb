require 'test_helper'

class AdminServices::Customer::AddCustomeromerTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @success_params = { first_name: "Test first name", last_name: "Test last name",
                        email: "test@test.com" }
    @blank_params = { first_name: "", last_name: "", email: ""}
  end

  test 'should create customer with valid params' do
    service = AdminServices::Customer::AddCustomer.new(shop_id: @shop.id, params: @success_params).run
    assert service.success?
    assert Customer.find_by_id(service.result.id)
    assert_equal "Test first name", service.result.first_name
    assert_equal 1, @shop.customers.count
  end

  test 'should not create customer with same params' do
    service = AdminServices::Customer::AddCustomer.new(shop_id: @shop.id, params: @success_params).run
    assert service.success?
    service2 = AdminServices::Customer::AddCustomer.new(shop_id: @shop.id, params: @success_params).run
    refute service2.success?
    assert_equal 1, @shop.customers.count
    assert_equal 1, service2.result.errors.count
    assert_equal "This customer is already exist in this shop", service2.result.errors[:base].first
  end

  test 'should not create customer with blank params' do
    service = AdminServices::Customer::AddCustomer.new(shop_id: @shop.id, params: @blank_params).run
    refute service.success?
    assert_equal 1, service.result.errors.count
    assert_equal "Email can't be blank", service.result.errors.full_messages[0]
    assert_equal 0, @shop.customers.count
  end
end
