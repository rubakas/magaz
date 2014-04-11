require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @checkout = @shop.checkouts.create
    @product_1 = create(:product, shop: @shop, handle: "handle1")
    @product_2 = create(:product, shop: @shop, handle: "handle2")
  end

  test 'attributes' do
    skip
  end

  test 'add_product and item_count' do
    assert_equal 0, @checkout.item_count
    @checkout.add_product(product: @product_1, quantity: 1)
    assert_equal 1, @checkout.item_count
    @checkout.add_product(product: @product_1, quantity: 1)
    assert_equal 2, @checkout.item_count
    @checkout.add_product(product: @product_2, quantity: 1)
    assert_equal 3, @checkout.item_count
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
