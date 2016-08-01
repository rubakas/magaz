require 'test_helper'
class AdminServices::TaxOverride::DeleteTaxOverrideTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shipping_country = create(:shipping_country, shop: @shop)
    @tax_override = create(:tax_override, shipping_country: @shipping_country, collection: @collection)
  end

  test "should destroy tax override with valid ids" do
    assert_equal 1, TaxOverride.count
    AdminServices::TaxOverride::DeleteTaxOverride
    .new(id: @tax_override.id)
    .run
    refute TaxOverride.find_by_id(@tax_override.id)
    assert_equal 0, TaxOverride.count
  end
end
