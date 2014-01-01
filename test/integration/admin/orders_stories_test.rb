require 'test_helper'

class Admin::OrdersStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @order = create(:order, shop: @shop)
    click_link 'Orders'
  end

  test "orders list none" do
    Order.delete_all
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