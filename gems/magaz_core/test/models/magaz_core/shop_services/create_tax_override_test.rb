require 'test_helper'

module MagazCore
  class ShopServices::CreateTaxOverrideTest < ActiveSupport::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      @country = create(:one_more_country)
      puts "*************************"
      puts @shop
      puts @user
      puts @country
      puts "*************************"
      @collection = create(:collection, shop: @shop, handle: "handle1")
      @shipping_country = create(:one_more_shipping_country, shop: @shop, country_id: @country.id)
      @params = { is_shipping: 'false', collection_id: @collection.id, rate: '48'}
      @blank_params = { is_shipping: false }
      @wrong_params = { is_shipping: false, collection_id: @collection.id, rate: "not_number" }
    end

    test 'create override with valid params' do
      service = MagazCore::ShopServices::CreateTaxOverride
                  .call(params: @params, shipping_country_id: @shipping_country.id)
      assert service.tax_override.persisted?
      assert_equal service.tax.collection_id, @collection.id
      assert_equal service.tax_override.rate, 48
    end

    # test 'fails to create tax_override with wrong params' do
    #   service = MagazCore::ShopServices::CreateTaxOverride
    #               .call(params: @blank_params, shipping_country_id: @shipping_country.id)
    #   assert_not service.tax_override.persisted?

    #   service = MagazCore::ShopServices::CreateTaxOverride
    #               .call(params: @wrong_params, shipping_country_id: @shipping_country.id)
    #   assert_not service.tax_override.persisted?
    # end
  end
end