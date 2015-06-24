module MagazStoreAdmin
require 'test_helper'

  class SessionControllerTest < ActionController::TestCase
    setup do
      @shop = create(:shop, subdomain: 'example')
      @user = create(:user, shop: @shop)
      @shop2 = create(:shop, name: 'example2', subdomain: 'example2')
      @user2 = create(:user, shop: @shop2, first_name: 'First2', last_name: 'Last2', email: 'email2@mail.com', password: 'password2')
      session_for_user @user
    end

    test "current_user is correct" do
      assert_equal MagazCore::User.find_by_id(session[:user_id]).first_name, @user.first_name
      session_for_user @user2
      assert_equal MagazCore::User.find_by_id(session[:user_id]).first_name, @user2.first_name
    end
  end
end