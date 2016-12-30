require 'test_helper'

class AdminServices::Shop::ChangeTaxesSettingsTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @collection = create(:collection, shop: @shop)
    @shop.update_attributes(eu_digital_goods_collection_id: @collection.id)
    @success_params = { all_taxes_are_included: false, charge_taxes_on_shipping_rates: true, charge_vat_taxes: 'charge_vat_taxes' }
    @specific_params = { all_taxes_are_included: true, charge_taxes_on_shipping_rates: false, charge_vat_taxes: '' }
  end

  test 'should update shop with valid params' do
    service = AdminServices::Shop::ChangeTaxesSettings
              .new(shop_id: @shop.id,
                   params: @success_params)
              .run
    assert service.success?
    assert service.shop
    assert service.shop.charge_taxes_on_shipping_rates
    refute service.shop.all_taxes_are_included
    assert_equal @collection.id,
                 service.shop.eu_digital_goods_collection_id
  end

  test 'should not update shop with blank params' do
    service = AdminServices::Shop::ChangeTaxesSettings.new(shop_id: @shop.id).run
    refute service.success?
    assert_equal 2, service.errors.count
    assert_includes service.errors.full_messages, "All taxes are included is not included in the list"
    assert_includes service.errors.full_messages, "Charge taxes on shipping rates is not included in the list"
  end

  test 'should update eu_digital_goods_collection_id to nil with blank charge_vat_taxes' do
    assert_equal @collection.id,
                 @shop.eu_digital_goods_collection_id
    service = AdminServices::Shop::ChangeTaxesSettings
              .new(shop_id: @shop.id,
                   params: @specific_params)
              .run
    assert_nil service.shop.eu_digital_goods_collection_id
  end

  test "should rise exeption if shop not found" do
    assert_raises ActiveRecord::RecordNotFound do
      service = AdminServices::Shop::ChangeTaxesSettings.new.run
    end
  end
end
