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
  end
end
