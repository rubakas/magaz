require 'test_helper'

class AdminServices::Shop::ChangeTaxesSettingsTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @collection = create(:collection, shop: @shop)
    @shop.update_attributes(eu_digital_goods_collection_id: @collection.id)
  end

  test 'should update shop with valid params' do
    service = AdminServices::Shop::ChangeTaxesSettings
              .run(id: @shop.id,
                   all_taxes_are_included: '0',
                   charge_taxes_on_shipping_rates: '1',
                   charge_vat_taxes: 'charge_vat_taxes')

    assert service.valid?
    assert service.result
    assert service.result.charge_taxes_on_shipping_rates
    refute service.result.all_taxes_are_included
    assert_equal @collection.id,
                 service.result.eu_digital_goods_collection_id
  end

  test 'should not update shop with blank params' do
    service = AdminServices::Shop::ChangeTaxesSettings
              .run(id: @shop.id,
                   all_taxes_are_included: '',
                   charge_taxes_on_shipping_rates: '',
                   charge_vat_taxes: '')

    refute service.valid?
    assert_equal 2, service.shop.errors.count
    assert_equal 'All taxes are included is not a valid boolean',
                 service.shop.errors.full_messages.first

    assert_equal 'Charge taxes on shipping rates is not a valid boolean',
                 service.shop.errors.full_messages.last
  end

  test 'should update eu_digital_goods_collection_id to nil with blank charge_vat_taxes' do
    assert_equal @collection.id,
                 @shop.eu_digital_goods_collection_id
    service = AdminServices::Shop::ChangeTaxesSettings
              .run(id: @shop.id,
                   all_taxes_are_included: '1',
                   charge_taxes_on_shipping_rates: '0',
                   charge_vat_taxes: '')
    assert_equal nil,
                 service.shop.eu_digital_goods_collection_id
  end

  test 'should not update eu_digital_goods_collection_id with charge_vat_taxes' do
    assert_equal @collection.id,
                 @shop.eu_digital_goods_collection_id
    service = AdminServices::Shop::ChangeTaxesSettings
              .run(id: @shop.id,
                   all_taxes_are_included: '1',
                   charge_taxes_on_shipping_rates: '0',
                   charge_vat_taxes: 'charge_vat_taxes')
    assert_equal @collection.id,
                 service.shop.eu_digital_goods_collection_id
  end
end
