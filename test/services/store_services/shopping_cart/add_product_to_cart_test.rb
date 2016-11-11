require 'test_helper'

class StoreServices::ShoppingCart::AddProductToCartTest < ActiveSupport::TestCase

  setup do
    @existing_shop      = create(:shop)
    @existing_customer  = create(:customer, shop:     @existing_shop)
    @existing_checkout 	= create(:checkout, customer: @existing_customer)
    @existing_product   = create(:product,  shop:     @existing_shop)
    @product = create(:product, shop: @existing_shop)
  end


  test 'add_product and item_count' do
    service = StoreServices::ShoppingCart::AddProductToCart
               .new( shop_id:     @existing_shop.id,
                     checkout_id: @existing_checkout.id,
                     customer_id: @existing_customer.id,
                     product_id:  @product.id,
                     quantity:    3)
               .run

    assert_equal 3, service.checkout.item_count
  end


  test 'should not add_product if quantity < 1' do
    service = StoreServices::ShoppingCart::AddProductToCart
               .new( shop_id:     @existing_shop.id,
                     checkout_id: @existing_checkout.id,
                     customer_id: @existing_customer.id,
                     product_id:  @product.id,
                     quantity:    0)
               .run
    refute service.success?
    assert_equal 0, service.checkout.item_count
    assert_includes service.errors.full_messages, "Quantity is invalid"
  end

  test 'should rise exeption with no params' do
    assert_raises ActiveRecord::RecordNotFound do
      service = StoreServices::ShoppingCart::AddProductToCart.new.run
    end
  end
end
