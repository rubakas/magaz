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
    assert service.shop
    assert_equal "authorize_and_charge", service.shop.authorization_settings
  end

  test 'should update authorization_settings to nil with wrong value' do
    service = AdminServices::Shop::ChangePaymentSettings
              .new(id: @shop.id,
                   authorization_settings: "wrong")
              .run
    refute service.success?
    assert_equal "Authorization settings type is undefined", service.errors.full_messages[0]
    assert service.shop.authorization_settings, nil
  end

  test 'should raise exeption if shop not found' do
    assert_raises ActiveRecord::RecordNotFound do
      service = AdminServices::Shop::ChangePaymentSettings
                .new(id: '',
                     authorization_settings: '')
                .run
      end
  end
end
