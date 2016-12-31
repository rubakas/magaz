require 'test_helper'

class StoreServices::ShoppingCart::UpdateAddressTest < ActiveSupport::TestCase

  setup do
    @existing_shop      = create(:shop)
    @existing_customer  = create(:customer, shop:     @existing_shop)
    @existing_checkout 	= create(:checkout, customer: @existing_customer)
    @existing_product   = create(:product,  shop:     @existing_shop)
  end

  test "should update address with correct params" do
    service =  StoreServices::ShoppingCart::UpdateAddress
                .new(shop_id:     @existing_shop.id,
                     checkout_id: @existing_checkout.id,
                     customer_id: @existing_customer.id,
                     address_attrs: { 'email' => "updatedaddress@mail.com" })
                .run
    assert service.success?
    assert_equal service.checkout, @existing_checkout
    assert_equal service.checkout.email, "updatedaddress@mail.com"
  end

  test "should not update with invalid address" do
    service =  StoreServices::ShoppingCart::UpdateAddress
                .new(shop_id:     @existing_shop.id,
                     checkout_id: @existing_checkout.id,
                     customer_id: @existing_customer.id,
                     address_attrs: { 'email' => "random" })
                .run

    refute service.success?
    assert_equal service.checkout, @existing_checkout
    assert_not_equal Checkout.find(service.checkout.id).email, "random"
  end

  test "should rise exeption with no params" do
    assert_raises ActiveRecord::RecordNotFound do
      StoreServices::ShoppingCart::UpdateAddress.new.run
    end
  end
end
