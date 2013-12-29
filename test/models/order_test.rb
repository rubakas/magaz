require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @shop = shops(:shop_1)
    @order = @shop.orders.create
    @product_1 = products(:product_1)
    @product_2 = products(:product_2)
  end

  test 'attributes' do
    skip
  end

  test 'add_product and item_count' do
    assert_equal 0, @order.item_count
    @order.add_product(product: @product_1, quantity: 1)
    assert_equal 1, @order.item_count
    @order.add_product(product: @product_1, quantity: 1)
    assert_equal 2, @order.item_count
    @order.add_product(product: @product_2, quantity: 1)
    assert_equal 3, @order.item_count
  end

  test 'items' do
    assert_equal [], @order.items
  end

  test 'note' do
    assert_equal nil, @order.note
  end

  test 'total_price' do
    assert_equal 0.0, @order.total_price
  end

  test 'total_weight' do
    assert_equal 0.0, @order.total_weight
  end
end
