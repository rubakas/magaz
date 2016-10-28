require 'test_helper'
class AdminServices::Product::DeleteProductTest < ActiveSupport::TestCase

 setup do
    @shop = create(:shop, name: "shop name")
    @product = create(:product, shop: @shop)
  end

  test "should delete image with valid params" do
    assert_equal 1, Product.count
    service = AdminServices::Product::DeleteProduct
              .new(id: @product.id, shop_id: @shop.id)
              .run
    assert service.success?
    assert_equal 0, Product.count
  end

end
