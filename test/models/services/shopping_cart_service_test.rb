require 'test_helper'

class ShoppingCartServiceTest < ActiveSupport::TestCase
	setup do
		@existing_shop 			= create(:shop)
		@existing_customer 	= create(:customer, shop: @existing_shop)
		@existing_checkout 	= create(:checkout, customer: @existing_customer)
	end

	test "initialization with existing stuff" do
    @service = ShoppingCartService.new shop_id: @existing_shop.id, 
    	checkout_id: @existing_checkout.id, 
    	customer_id: @existing_customer.id

    assert_equal @service.shop, @existing_shop
    assert_equal @service.checkout, @existing_checkout
    assert_equal @service.customer, @existing_customer
  end

	test "initialization with missing stuff" do
    @missing_checkout_service = ShoppingCartService.new shop_id: @existing_shop.id, 
    	checkout_id: 'dont exist', 
    	customer_id: @existing_customer.id

    assert_equal @missing_checkout_service.shop, @existing_shop
    assert_not_nil @missing_checkout_service.checkout
    assert_equal @missing_checkout_service.customer, @existing_customer


    @missing_checkout_and_customer_service = ShoppingCartService.new shop_id: @existing_shop.id, 
    	checkout_id: 'do not exist',
    	customer_id: 'do not exist'

    assert_equal @missing_checkout_and_customer_service.shop, @existing_shop
    assert_not_nil @missing_checkout_and_customer_service.checkout
    assert_not_nil @missing_checkout_and_customer_service.customer
    refute_equal @missing_checkout_and_customer_service.checkout, @existing_checkout
    refute_equal @missing_checkout_and_customer_service.customer, @existing_customer
  end

  
end