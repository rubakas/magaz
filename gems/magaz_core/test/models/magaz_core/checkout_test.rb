# == Schema Information
#
# Table name: checkouts
#
#  id                 :integer          not null, primary key
#  note               :text
#  status             :string
#  financial_status   :string
#  fulfillment_status :string
#  currency           :string
#  email              :string
#  created_at         :datetime
#  updated_at         :datetime
#  customer_id        :integer
#

require 'test_helper'

module MagazCore
  class CheckoutTest < ActiveSupport::TestCase

    should belong_to(:customer)
    should have_many(:line_items)
    should have_many(:events)

    setup do
      @shop = create(:shop)
      @customer = create(:customer, shop: @shop)
      @checkout = create(:checkout, customer: @customer)
      @product_1 = create(:product, shop: @shop)
      @product_2 = create(:product, shop: @shop)
      @open_checkout = create(:checkout, customer: @customer, status: "open")
      @cancelled_checkout = create(:checkout, customer: @customer, status: "cancelled")
      @checkout_with_email_and_status = create(:checkout, customer: @customer, status: "open", email: "some@email.com")
    end

    test 'attributes' do
      skip
    end

    test 'items' do
      assert_equal [], @checkout.items
    end

    test 'note' do
      assert_equal nil, @checkout.note
    end

    test 'total_price' do
      assert_equal 0.0, @checkout.total_price
    end

    test 'total_weight' do
      assert_equal 0.0, @checkout.total_weight
    end

    test "scope orders" do
      assert_equal @open_checkout, MagazCore::Checkout.orders.find_by_id(@open_checkout)
      assert_equal @cancelled_checkout, MagazCore::Checkout.orders.find_by_id(@cancelled_checkout)
    end

    test "scope not_orders" do
      assert_equal @checkout, MagazCore::Checkout.not_orders.find_by_id(@checkout)
    end

    test "scope abandoned_checkouts" do
      assert_equal @checkout_with_email_and_status, MagazCore::Checkout.abandoned_checkouts.find_by_id(@checkout_with_email_and_status)
    end

    test "checkout can be in many scopes" do
      assert_equal @checkout_with_email_and_status, MagazCore::Checkout.abandoned_checkouts.find_by_id(@checkout_with_email_and_status)
      assert_equal @checkout_with_email_and_status, MagazCore::Checkout.orders.find_by_id(@checkout_with_email_and_status)
    end
  end
end
