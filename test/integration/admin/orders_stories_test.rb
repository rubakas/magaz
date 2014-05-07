require 'test_helper'

class Admin::OrdersStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @customer = create(:customer, shop: @shop)
    @checkout = create(:checkout, customer: @customer)
    @order = create(:checkout, customer: @customer, status: MagazCore::Checkout::STATUSES.first)
    click_link 'Orders'
  end

  test "orders list none" do
    MagazCore::Checkout.delete_all
    login
    click_link 'Orders'
    assert page.has_content? 'You have no orders yet'
  end

  test "orders list all" do
    assert page.has_content? "##{@order.id}"
  end

  test "orders list cancelled" do
    assert page.has_content? "##{@order.id}"
  end

  test "show order" do
    skip
  end

  test "cancel order" do
    skip
  end

  test "fulfill order" do
    skip
  end
end