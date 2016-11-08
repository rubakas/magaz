require 'test_helper'

class AdminServices::Checkout::DeleteCheckoutTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @customer = create(:customer, shop: @shop)
    @abandoned_checkout = create(:checkout, customer: @customer, email: "someuniqemail@mail.com")
  end

  test 'should delete checkout with valid id' do
    assert_equal 1, @shop.checkouts.count
    service = AdminServices::Checkout::DeleteCheckout
              .new(id: @abandoned_checkout.id)
              .run
    assert service.success?
    refute Checkout.find_by_id(@abandoned_checkout.id)
    assert_equal 0, @shop.checkouts.count
  end
end
