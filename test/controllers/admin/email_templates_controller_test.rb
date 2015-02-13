require 'test_helper'

class Admin::EmailTemplatesControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop)
    session_for_user @user
    @email_template = create(:email_template, shop: @shop)
  end

  test "should preview text of email_template" do
    get :show,
      id: @email_template
    assert_response :success
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
