require 'test_helper'

class AdminServices::Checkout::ChangeOrderTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: 'shop_name')
    @customer = create(:customer, shop: @shop)
    @checkout = create(:checkout, customer: @customer)
    @order = create(:checkout, customer: @customer, status: Checkout::STATUSES.first)
    @success_params = { 'status' => 'open' }
    @blank_params =   { 'status' => '' }
  end

  test 'should update order with valid params' do
    service = AdminServices::Checkout::ChangeOrder
              .new( id: @checkout.id,
                    params: @success_params)
              .run
    assert service.success?
    assert service.result
    assert_equal 'open', Checkout.find(@checkout.id).status
  end

  test 'should not update order with valid params' do
    service = AdminServices::Checkout::ChangeOrder
              .new( id: @order.id, 
                    params: @blank_params)
              .run

    refute service.success?
    assert_equal 1, service.result.errors.count
    assert_equal "Status can't be blank", service.result.errors.full_messages.first
    assert_not_equal 'open', Checkout.find(@checkout.id).status
  end

end
