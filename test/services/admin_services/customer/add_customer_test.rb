require 'test_helper'

class AdminServices::Customer::AddCustomeromerTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')

    @success_params = {
      'first_name' => "Test first name",
      'last_name' => "Test last name",
      'email'     => "test@test.com"
    }

    @blank_params = {
      'first_name'  => "",
      'last_name'   => "",
      'email'       => ""
    }
  end

  test 'should create customer with valid params' do
    service = AdminServices::Customer::AddCustomer
              .new( shop_id:  @shop.id,
                    params:   @success_params)
              .run
    assert service.success?
    assert Customer.find_by_id(service.customer.id)
    assert_equal "Test first name", service.customer.first_name
    assert_equal 1, @shop.customers.count
  end

  test 'should not create customer with same params' do
    service = AdminServices::Customer::AddCustomer
              .new( shop_id:  @shop.id,
                    params:   @success_params)
              .run
    assert service.success?
    service2 =  AdminServices::Customer::AddCustomer
                .new( shop_id:  @shop.id,
                      params:   @success_params)
                .run
    refute service2.success?
    assert_equal 1, @shop.customers.count
    assert_equal 1, service2.customer.errors.count
    assert_includes service2.customer.errors.full_messages, "Email has already been taken"
  end

  test 'should not create customer with blank params' do
    service = AdminServices::Customer::AddCustomer
              .new(shop_id: @shop.id)
              .run
    refute service.success?
    assert_equal 1, service.customer.errors.count
    assert_includes service.customer.errors.full_messages, "At least one of these fields must be filled: First name, Last name, Email"
    assert_equal 0, @shop.customers.count
  end

  test "should rise exeption if shop not found" do
    assert_raises ActiveRecord::RecordNotFound do
      service = AdminServices::Customer::AddCustomer
                .new(shop_id: "")
                .run
    end
  end
end
