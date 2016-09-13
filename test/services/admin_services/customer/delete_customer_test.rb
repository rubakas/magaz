require 'test_helper'

class AdminServices::Customer::DeleteCustomerTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @customer = create(:customer, shop: @shop)
    @customer2 = create(:customer, shop: @shop)
  end

  test 'should delete customer with valid id' do
    assert_equal 2, @shop.customers.count
    service = AdminServices::Customer::DeleteCustomer
                .new(id: @customer.id, shop_id: @shop.id)
                .run
    assert service.success?
    refute Customer.find_by_id(@customer.id)
    assert Customer.find_by_id(@customer2.id)
    assert_equal 1, @shop.customers.count
  end

  test 'should raise exeption with blank params' do
    assert_equal 2, Customer.count
    assert_raises ActiveRecord::RecordNotFound do
      service = AdminServices::Customer::DeleteCustomer.new.run
    end
  end
end
