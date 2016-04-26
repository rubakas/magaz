require 'test_helper'
class MagazCore::AdminServices::TaxOverride::DeleteTaxOverrideTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shipping_country = create(:shipping_country, shop: @shop)
    @tax_override = create(:tax_override, shipping_country: @shipping_country)
  end

  test "should destroy tax override with valid ids" do
    assert_equal 1, MagazCore::TaxOverride.count
    service = MagazCore::AdminServices::TaxOverride::DeleteTaxOverride
                .run(id: @tax_override.id)
    refute MagazCore::TaxOverride.find_by_id(@tax_override.id)
    assert_equal 0, MagazCore::TaxOverride.count
  end

  test "should not destroy tax override with blank ids" do
    assert_equal 1, MagazCore::TaxOverride.count
    service = MagazCore::AdminServices::TaxOverride::DeleteTaxOverride
                .run(id: '')
    assert MagazCore::TaxOverride.find_by_id(@tax_override.id)
    assert_equal 1, service.errors.count
    assert_equal "Id is not a valid integer", service.errors.full_messages.first
    assert_equal 1, MagazCore::TaxOverride.count
  end

end
