require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase
  setup do
    @shop = create(:shop)
    @customer = @shop.customers.create
    @checkout = @customer.checkouts.create
    @product_1 = create(:product, shop: @shop)
    @product_2 = create(:product, shop: @shop)
  end

  test 'attributes' do
    skip
  end

  test 'items' do
    assert_equal [], @checkout.items
  end

  test 'note' do
    assert_equal nil, @checkout.note
  end

  test 'total_price' do
    assert_equal 0.0, @checkout.total_price
  end

  test 'total_weight' do
    assert_equal 0.0, @checkout.total_weight
  end
end