require 'test_helper'

class MagazCore::AdminServices::Shop::ChangeTaxesSettingsTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
  end

  test 'should update shop with valid params' do
    service = MagazCore::AdminServices::Shop::ChangeTaxesSettings
                .run(id: @shop.id,
                     all_taxes_are_included: '0',
                     charge_taxes_on_shipping_rates: '1')

    assert service.valid?
    assert service.result
    assert service.result.charge_taxes_on_shipping_rates
    refute service.result.all_taxes_are_included
  end

  test 'should update authorization_settings to nil with blank params' do
    service = MagazCore::AdminServices::Shop::ChangeTaxesSettings
                .run(id: @shop.id,
                     all_taxes_are_included: '',
                     charge_taxes_on_shipping_rates: '')

    refute service.valid?
    assert_equal 2, service.errors.count
    assert_equal 'All taxes are included is not a valid boolean',
                 service.errors.full_messages.first

    assert_equal 'Charge taxes on shipping rates is not a valid boolean',
                 service.errors.full_messages.last
  end
end
