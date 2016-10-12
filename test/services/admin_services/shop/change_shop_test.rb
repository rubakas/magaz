require 'test_helper'

class AdminServices::Shop::ChangeShopTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @success_params = { id: @shop.id, shop_params: {
                        name: 'Name',
                        business_name: 'business_name', city: 'city',
                        country: 'US', currency: 'USD',
                        customer_email: 'some@email.com', phone: 'phone',
                        timezone: 'American Samoa', unit_system: 'metric',
                        zip: 'zip', page_title: 'page_title',
                        meta_description: 'meta_description', address: 'address'}}

    @wrong_params = { id: @shop.id, shop_params: {
                      name: 'Name',
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
                    }
  end

  test 'should update shop with valid params' do
    service = AdminServices::Shop::ChangeShop.new(@success_params).run
    assert service.success?
    assert_equal 'Name', service.shop.name
    assert_equal 'USD', service.shop.currency
    assert_equal 'some@email.com', service.shop.customer_email
    assert_equal 'phone', service.shop.phone
    assert_equal 'metric', service.shop.unit_system
    assert_equal 'American Samoa', service.shop.timezone
  end

  test 'should not update shop with blank name' do
    params = @success_params
    params[:shop_params][:name] = ''
    service = AdminServices::Shop::ChangeShop.new(params).run
    refute service.success?
    assert_equal 1, service.shop.errors.count
    assert_includes service.shop.errors.full_messages, "Name can't be blank"
  end

  test 'should not update shop with wrong params' do
    service = AdminServices::Shop::ChangeShop.new(@wrong_params).run
    refute service.success?
    assert_equal 5, service.shop.errors.count
    assert_equal "Country is not included in the list",
                 service.shop.errors.full_messages.first
    assert_equal "Unit system is not included in the list",
                 service.shop.errors.full_messages[1]
    assert_equal "Currency is not included in the list",
                 service.shop.errors.full_messages[2]
    assert_equal "Timezone is not included in the list",
                 service.shop.errors.full_messages[3]
    assert_equal "Customer email is invalid",
                 service.shop.errors.full_messages.last
  end
end
