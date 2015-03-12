require 'test_helper'

class Admin::TaxesSettingsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @country = create(:country)
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shop.update_attributes(eu_digital_goods_collection_id: @collection.id)
    @shipping_country = create(:shipping_country, shop: @shop)
    @tax_override = create(:tax_override, collection_id: @collection, shipping_country: @shipping_country)
    visit '/admin/settings/taxes_settings'
  end

  test "settings form" do
    assert page.has_content? 'Taxes'
  end
end