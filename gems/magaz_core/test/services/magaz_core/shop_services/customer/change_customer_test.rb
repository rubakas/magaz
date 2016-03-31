require 'test_helper'

class MagazCore::ShopServices::Customer::ChangeCustomerTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @customer = create(:customer, shop: @shop)
    @customer2 = create(:customer, shop: @shop)
    @success_params = { id: @customer.id, first_name: "Changed first name",
                        last_name: "CHanged last name", email: "Changedtest@test.com",
                        shop_id: @shop.id }
    @blank_params =   { id: nil, first_name: "", last_name: "", email: '', shop_id: nil }
  end

  test 'should update customer with valid params' do
    service = MagazCore::ShopServices::Customer::ChangeCustomer.run(@success_params)
    assert service.valid?
    assert_equal "Changedtest@test.com", MagazCore::Customer.find(@customer.id).email
    assert_equal 'Changed first name', MagazCore::Customer.find(@customer.id).first_name
  end

  test 'should not update customer with blank_params' do
    service = MagazCore::ShopServices::Customer::ChangeCustomer.run(@blank_params)
    refute service.valid?
    assert_equal 2, service.errors.full_messages.count
  end

  test 'should not update customer with existing email' do
    service = MagazCore::ShopServices::Customer::ChangeCustomer
                                                .run( id: @customer.id,
                                                      first_name: "Changed first name",
                                                      last_name: "CHanged last name",
                                                      email: @customer2.email,
                                                      shop_id: @shop.id )
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "This customer is already exist in this shop", service.errors
                                                                    .full_messages.first
  end

  test 'should update customer with some blank params' do
    service = MagazCore::ShopServices::Customer::ChangeCustomer
                                              .run( id: @customer.id,
                                                    first_name: "Changed first name",
                                                    last_name: '', email: @customer.email,
                                                    shop_id: @shop.id )
    assert service.valid?
    assert_equal '', service.result.last_name
  end
end