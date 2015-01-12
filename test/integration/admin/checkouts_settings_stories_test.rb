require 'test_helper'

class Admin::CheckoutsSettingsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    click_link "Settings"
    click_link "Checkouts" 
  end

  test "settings form" do
    assert page.has_content? 'Checkouts'
  end

  test "update checkouts settings" do
    assert_not page.has_css?('.js-checkouts_hidden_field_multipass')
    assert page.has_css?('.js-checkouts_hidden_field_auto_fulfill') 
    find('#shop_account_type_choice').find(:xpath, 'option[1]').select_option
    find('#shop_abandoned_checkout_time_delay').find(:xpath, 'option[1]').select_option
    find('#shop_email_marketing_choice').find(:xpath, 'option[1]').select_option
    find('#shop_after_order_paid').find(:xpath, 'option[2]').select_option
    check('shop_after_order_fulfilled_and_paid')    
    click_button 'Save'
    assert page.has_content? 'Shop was successfully updated.'
  end
end
