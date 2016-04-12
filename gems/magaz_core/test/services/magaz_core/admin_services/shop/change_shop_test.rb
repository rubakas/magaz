require 'test_helper'

class MagazCore::AdminServices::Shop::ChangeShopTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @success_params = {name: 'Name', id: @shop.id,
                       business_name: 'business_name', city: 'city',
                       country: 'USA', currency: 'USD',
                       customer_email: 'some@email.com', phone: 'phone',
                       timezone: 'American Samoa', unit_system: 'metric',
                       zip: 'zip', page_title: 'page_title',
                       meta_description: 'meta_description', address: 'address'}
  end

  test 'should update shop with valid params' do
    service = MagazCore::AdminServices::Shop::ChangeShop.run(@success_params)
    assert service.valid?
    assert_equal 'Name', service.result.name
    assert_equal 'USD', service.result.currency
    assert_equal 'some@email.com', service.result.customer_email
    assert_equal 'phone', service.result.phone
    assert_equal 'metric', service.result.unit_system
    assert_equal 'American Samoa', service.result.timezone
  end
end
