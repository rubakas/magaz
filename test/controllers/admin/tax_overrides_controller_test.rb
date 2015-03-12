require 'test_helper'

class Admin::TaxOverridesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @collection = create(:collection, shop: @shop, handle: "handle1")
    @shipping_country = create(:shipping_country, shop: @shop)
    @tax_override = create(:tax_override, collection_id: @collection, shipping_country_id: @shipping_country)
  end
end