require 'test_helper'

class MagazCore::AdminServices::Checkout::ChangeOrderTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @customer = create(:customer, shop: @shop)
    @checkout = create(:checkout, customer: @customer)
    @order = create(:checkout, customer: @customer, status: MagazCore::Checkout::STATUSES.first)
    @success_params = { id: @checkout.id,
                        status: 'open'}

    @blank_params =   { id: @checkout.id,
                        status: '' }
  end

  test 'should update order with valid params' do
    service = MagazCore::AdminServices::Checkout::ChangeOrder.run(@success_params)
    assert service.valid?
    assert service.order
    assert_equal 'open', MagazCore::Checkout.find(@checkout.id).status
  end

  test 'should not update order with valid params' do
    service = MagazCore::AdminServices::Checkout::ChangeOrder.run(@blank_params)
    refute service.valid?
    assert_equal 1, service.order.errors.count
    assert_equal "Status can't be blank", service.order.errors.full_messages.first
    assert_not_equal 'open', MagazCore::Checkout.find(@checkout.id).status
  end

end
