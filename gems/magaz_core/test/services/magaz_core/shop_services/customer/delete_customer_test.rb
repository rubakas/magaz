require 'test_helper'

module MagazCore
  class ShopServices::DeleteCustomerTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop, name: 'shop_name')
      @customer = create(:customer, shop: @shop)
      @customer2 = create(:customer, shop: @shop)
    end

    test 'should delete customer with valid id' do
      assert_equal 2, @shop.customers.count
      service = MagazCore::ShopServices::DeleteCustomer.run(id: @customer.id)
      assert service.valid?
      refute MagazCore::Customer.find_by_id(@customer.id)
      assert MagazCore::Customer.find_by_id(@customer2.id)
      assert_equal 1, @shop.customers.count
    end

    test 'should not delete customer with valid blank id' do
      assert_equal 2, @shop.customers.count
      service = MagazCore::ShopServices::DeleteCustomer.run(id: "")
      refute service.valid?
      assert_equal 2, @shop.customers.count
    end
  end
end