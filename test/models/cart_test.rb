require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = Cart.new
    @product_1 = products(:product_1)
    @product_2 = products(:product_2)
  end

  test 'attributes' do
    skip
  end

  test 'add_product and item_count' do
    assert_equal 0, @cart.item_count
    @cart.add_product(product: @product_1, quantity: 1)
    assert_equal 1, @cart.item_count
    @cart.add_product(product: @product_2, quantity: 2)
    assert_equal 3, @cart.item_count
  end

  test 'items' do
    assert_equal [], @cart.items
  end

  test 'note' do
    assert_equal nil, @cart.note
  end

  test 'total_price' do
    assert_equal 0.0, @cart.total_price
  end

  test 'total_weight' do
    assert_equal 0.0, @cart.total_weight
  end
end
