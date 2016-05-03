require 'test_helper'

class MagazCore::AdminServices::Shop::ChangeShopTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @success_params = {name: 'Name', id: @shop.id,
                       business_name: 'business_name', city: 'city',
                       country: 'US', currency: 'USD',
                       customer_email: 'some@email.com', phone: 'phone',
                       timezone: 'American Samoa', unit_system: 'metric',
                       zip: 'zip', page_title: 'page_title',
                       meta_description: 'meta_description', address: 'address'}

    @wrong_params = {name: 'Name',
                     id: @shop.id,
                     business_name: 'business_name',
                     city: 'city',
                     country: 'wrong country',
                     currency: 'wrong currency',
                     customer_email: 'wrong email',
                     phone: 'phone',
                     timezone: 'wrong country',
                     unit_system: 'wrong system',
                     zip: 'zip',
                     page_title: 'page_title',
                     meta_description: 'meta_description',
                     address: 'address'}
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

  test 'should not update shop with blank name' do
    params = @success_params
    params[:name] = ''
    service = MagazCore::AdminServices::Shop::ChangeShop.run(params)
    refute service.valid?
    assert_equal 1, service.shop.errors.count
    assert_equal "Name can't be blank", service.shop.errors.full_messages.last
  end

  test 'should not update shop with wrong params' do
    service = MagazCore::AdminServices::Shop::ChangeShop.run(@wrong_params)
    refute service.valid?
    assert_equal 5, service.shop.errors.count
    assert_equal "Country is not included in the list",
                 service.shop.errors.full_messages.first
    assert_equal "Unit system is not included in the list",
                 service.shop.errors.full_messages[1]
    assert_equal "Currency is not included in the list",
                 service.shop.errors.full_messages[2]
    assert_equal "Timezone is not included in the list",
                 service.shop.errors.full_messages[3]
    assert_equal "Customer email is not valid",
                 service.shop.errors.full_messages.last
  end
end
