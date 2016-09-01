require 'test_helper'

class AdminServices::Shop::ChangePaymentSettingsTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
  end

  test 'should update shop with valid params' do
    service = AdminServices::Shop::ChangePaymentSettings
              .new(id: @shop.id,
                   authorization_settings: 'authorize_and_charge')
              .run
    assert service.success?
    assert service.result
    assert_equal "authorize_and_charge", service.result.authorization_settings
  end

  test 'should update authorization_settings to nil with wrong value' do
    service = AdminServices::Shop::ChangePaymentSettings
              .run(id: @shop.id,
                   authorization_settings: "wrong")

    assert service.valid?
    assert service.result
    refute service.result.authorization_settings
  end
end
