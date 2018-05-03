# == Schema Information
#
# Table name: shipping_countries
#
#  id      :integer          not null, primary key
#  name    :string
#  tax     :string
#  shop_id :integer
#

require 'test_helper'

class ShippingCountryTest < ActiveSupport::TestCase
  setup do
    @shop = create(:shop)
    @shipping_country = create(:shipping_country, shop: @shop)
  end

  # associations
  should have_many(:shipping_rates).dependent(:destroy)
  should belong_to  :shop
  should have_many  :tax_overrides

  # validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).scoped_to(:shop_id)
  should validate_presence_of(:shop_id)
  should validate_presence_of(:tax)
  should validate_numericality_of(:tax)

  test "should return country info" do
    assert_equal @shipping_country.country_info['iso_2'], @shipping_country.name
  end
end
