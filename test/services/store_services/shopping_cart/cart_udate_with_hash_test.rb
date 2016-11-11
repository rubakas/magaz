require 'test_helper'

class StoreServices::ShoppingCart::CartUpdateWithHashTest < ActiveSupport::TestCase

  setup do
    @existing_shop      = create(:shop)
    @existing_customer  = create(:customer, shop:     @existing_shop)
    @existing_checkout 	= create(:checkout, customer: @existing_customer)
    @existing_product_1   = create(:product,  shop:     @existing_shop)
    @existing_product_2   = create(:product,  shop:     @existing_shop)
    @id_qty_hash = { @existing_product_1.id => 2, @existing_product_2.id => 3 }
  end


  test 'should add products with quantity from hash' do
    service = StoreServices::ShoppingCart::CartUpdateWithHash
               .new( shop_id:     @existing_shop.id,
                     checkout_id: @existing_checkout.id,
                     customer_id: @existing_customer.id,
                     id_qty_hash: @id_qty_hash)
               .run

    assert service.success?
    assert_equal service.checkout.line_items[0].quantity, 2
    assert_equal service.checkout.line_items[1].quantity, 3
    assert_equal service.checkout.line_items[0].product_id, @existing_product_1.id
    assert_equal service.checkout.line_items[1].product_id, @existing_product_2.id
  end

  test 'should rise exeption with no params' do
    assert_raises ActiveRecord::RecordNotFound do
      service = StoreServices::ShoppingCart::CartUpdateWithHash.new.run
    end
  end
end
