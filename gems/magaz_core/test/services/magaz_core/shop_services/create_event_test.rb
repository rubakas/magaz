require 'test_helper'

module MagazCore
  class ShopServices::CreateEventTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      @product = create(:product, shop: @shop)
    end

    test 'fails to create tax_override with wrong params' do
      service = MagazCore::ShopServices::CreateEvent
                   .call(subject: @product,
                         message: "Some some",
                         description: "Some some")
      assert service.event.persisted?
      assert_equal service.event.subject_id, @product.id
      assert_equal service.event.subject_type, "Product"
    end
  end
end