require 'test_helper'

class MagazCore::AdminServices::Customer::DeleteCustomerTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @customer = create(:customer, shop: @shop)
    @customer2 = create(:customer, shop: @shop)
  end

  test 'should delete customer with valid id' do
    assert_equal 2, @shop.customers.count
    service = MagazCore::AdminServices::Customer::DeleteCustomer
                .run(id: @customer.id, shop_id: @shop.id)
    assert service.valid?
    refute MagazCore::Customer.find_by_id(@customer.id)
    assert MagazCore::Customer.find_by_id(@customer2.id)
    assert_equal 1, @shop.customers.count
  end

  test 'should not delete customer with valid blank id' do
    assert_equal 2, MagazCore::Customer.count
    service = MagazCore::AdminServices::Customer::DeleteCustomer.run(id: "", shop_id: '')
    refute service.valid?
    assert_equal 2, service.errors.count
    assert_equal "Id is not a valid integer", service.errors.full_messages.first 
    assert_equal 2, MagazCore::Customer.count
  end
end
