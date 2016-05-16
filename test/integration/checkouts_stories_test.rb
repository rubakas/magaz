require 'test_helper'

class CheckoutsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @customer = create(:customer, shop: @shop)
    @abandoned_checkout = create(:checkout, customer: @customer, email: "Some Uniq Email")
  end

  test "checkouts list none" do
    MagazCore::Checkout.delete_all
    login
    click_link 'Orders'
    click_link 'Abandoned Checkouts'
    assert page.has_content? 'You have no checkouts yet'
  end

  test "checkouts list all" do
    login
    click_link 'Orders'
    click_link 'Abandoned Checkouts'
    assert page.has_content? "#{@abandoned_checkout.id}"
  end
end