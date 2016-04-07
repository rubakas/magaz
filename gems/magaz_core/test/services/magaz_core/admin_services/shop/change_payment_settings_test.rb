require 'test_helper'

class MagazCore::AdminServices::Shop::ChangePaymentSettingsTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
  end

  test 'should update shop with valid params' do
    service = MagazCore::AdminServices::Shop::ChangePaymentSettings
                .run(id: @shop.id,
                     authorization_settings: 'authorize_and_charge')

    assert service.valid?
    assert service.result
    assert_equal "Authorize the customers credit card.", service.result.authorization_settings
  end

  test 'should update authorization_settings to nil with wrong value' do
    service = MagazCore::AdminServices::Shop::ChangePaymentSettings
                .run(id: @shop.id,
                     authorization_settings: "wrong")

    assert service.valid?
    assert service.result
    refute service.result.authorization_settings
  end
end
