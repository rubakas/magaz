require 'test_helper'

class AdminServices::User::DeleteUserTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "Shop name")
    @shop_owner = create(:user, shop: @shop, account_owner: true)
    @user = create(:user, shop: @shop)
  end

  test "should delete user with valid params" do
    assert_equal 2, User.count
    assert User.find(@user.id)
    service = AdminServices::User::DeleteUser
              .new(id: @user.id)
              .run
    assert service.success?
    assert_equal 1, User.count
  end

  test "should not delete shop owner" do
    assert_equal 2, User.count
    service = AdminServices::User::DeleteUser
              .new(id: @shop_owner.id)
              .run
    refute service.success?
    assert_equal 2, User.count
    assert_equal "Can't delete shop owner.", service.result.errors.full_messages.first
  end
end
