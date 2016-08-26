require 'test_helper'

class StoreServices::ShoppingCartTest < ActiveSupport::TestCase

  setup do
    @existing_shop      = create(:shop)
    @existing_customer  = create(:customer, shop: @existing_shop)
    @existing_checkout 	= create(:checkout, customer: @existing_customer)
    @existing_product   = create(:product, shop: @existing_shop)
  end

  test "initialization with existing stuff" do
    @service =  StoreServices::ShoppingCart
                .new(shop_id:     @existing_shop.id,
                     checkout_id: @existing_checkout.id,
                     customer_id: @existing_customer.id)

    assert_equal @service.shop, @existing_shop
    assert_equal @service.checkout, @existing_checkout
    assert_equal @service.customer, @existing_customer
  end

  test "initialization with missing stuff" do
    @missing_checkout_service =
      StoreServices::ShoppingCart
      .new(shop_id:     @existing_shop.id,
           checkout_id: 'dont exist',
           customer_id: @existing_customer.id)

    assert_equal @missing_checkout_service.shop, @existing_shop
    assert_not_nil @missing_checkout_service.checkout
    assert_equal @missing_checkout_service.customer, @existing_customer

    @missing_checkout_and_customer_service =
      StoreServices::ShoppingCart
      .new(shop_id:       @existing_shop.id,
           checkout_id:   'do not exist',
           customer_id:   'do not exist')

    assert_equal @missing_checkout_and_customer_service.shop, @existing_shop
    assert_not_nil @missing_checkout_and_customer_service.checkout
    assert_not_nil @missing_checkout_and_customer_service.customer
    refute_equal @missing_checkout_and_customer_service.checkout, @existing_checkout
    refute_equal @missing_checkout_and_customer_service.customer, @existing_customer
  end

  test 'add_product and item_count' do
    @service =  StoreServices::ShoppingCart
                .new( shop_id: @existing_shop.id,
                      checkout_id: nil,
                      customer_id: nil)

    @checkout = @service.checkout

    @product_1 = create(:product, shop: @existing_shop)
    @product_2 = create(:product, shop: @existing_shop)

    assert_equal 0, @checkout.item_count

    @service.add_product(product: @product_1, quantity: 1)
    assert_equal 1, @checkout.item_count

    @service.add_product(product: @product_1, quantity: 1)
    assert_equal 2, @checkout.item_count

    @service.add_product(product: @product_2, quantity: 1)
    assert_equal 3, @checkout.item_count
  end
end
