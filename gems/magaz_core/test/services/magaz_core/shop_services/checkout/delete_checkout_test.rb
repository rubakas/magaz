require 'test_helper'

class MagazCore::ShopServices::Checkout::DeleteCheckoutTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @customer = create(:customer, shop: @shop)
    @abandoned_checkout = create(:checkout, customer: @customer, email: "Some Uniq Email")
  end

  test 'should delete checkout with valid id' do
    assert_equal 1, @shop.checkouts.count
    service = MagazCore::ShopServices::Checkout::DeleteCheckout.run(id: @abandoned_checkout.id)
    assert service.valid?
    refute MagazCore::Checkout.find_by_id(@abandoned_checkout.id)
    assert_equal 0, @shop.checkouts.count
  end

  test 'should not checkout blog with blank id' do
    assert_equal 1, @shop.checkouts.count
    service = MagazCore::ShopServices::Checkout::DeleteCheckout.run(id: "")
    refute service.valid?
    assert_equal 1, @shop.checkouts.count
  end
end
