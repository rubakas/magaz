require 'test_helper'

class Admin::EmailTemplatesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    session_for_shop @shop
    @email_template = create(:email_template, shop: @shop)
  end

  test "should edit email_template" do
    get :edit,
        id: @email_template
    assert_response :success
  end

  test "should update email_template" do
    patch :update,
      { id: @email_template.id,
        product: { name: @email_template.name,
                   title: @email_template.title,
                   body: @email_template.body,
                   template_type: @email_template.template_type } }
    assert_redirected_to notifications_settings_admin_settings_path
  end
end
