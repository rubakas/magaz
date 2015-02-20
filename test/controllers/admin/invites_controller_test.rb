require 'test_helper'

class Admin::InvitesControllerTest < ActionController::TestCase

  setup do
    @shop = create(:shop, subdomain: 'example')
    @sender = create(:user, shop: @shop)
    session_for_user @sender
    @invite = create(:invite, shop: @shop)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invite" do
    assert_difference('MagazCore::Invite.count') do
      post :create, { invite: { email: 'email@mail.com',
                                sender_id: @sender.id,
                                shop_id: @shop.id,
                                token: '02a8667398e45c0bf1584e8a27ec792ff7a04447' } }
    end

    assert_redirected_to admin_users_path
  end

  test "should destroy invite" do
    assert_difference('MagazCore::Invite.count', -1) do
      delete :destroy, id: @invite.id
    end

    assert_redirected_to root_path
  end
end
