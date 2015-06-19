module MagazStoreAdmin
require 'test_helper'

class WebhooksControllerTest < ActionController::TestCase
  setup do
    @shop = create(:shop, subdomain: 'example')
    @user = create(:user, shop: @shop, account_owner: true)
    session_for_user @user
    @webhook = create(:webhook, shop: @shop)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:webhooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show webhook" do
    get :show, id: @webhook.id
    assert_response :success
  end

  test "should update webhook" do
    patch :update,
      { id: @webhook.id,
        webhook: { address: @webhook.address,
                   format: @webhook.format,
                   topic: @webhook.topic } }
    assert_redirected_to webhook_path(assigns(:webhook))
  end

  test "should not update webhook" do
    patch :update,
      { id: @webhook.id,
        webhook: { address: ' ' } }
    assert_template :show
    assert_response :success
  end

  test "should destroy webhook" do
    assert_difference('MagazCore::Webhook.count', -1) do
      delete :destroy, id: @webhook.id
    end

    assert_redirected_to webhooks_path
  end
end
end
