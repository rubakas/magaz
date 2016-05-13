require 'test_helper'

class MagazCore::AdminServices::User::DeleteUserTest < ActiveSupport::TestCase

  setup do 
    @shop = create(:shop, name: "Shop name")
    @shop_owner = create(:user, shop: @shop, account_owner: true)
    @user = create(:user, shop: @shop)
  end

  test "should delete user with valid params" do
    assert_equal 2, MagazCore::User.count
    assert MagazCore::User.find(@user.id)
    service = MagazCore::AdminServices::User::DeleteUser.run(id: @user.id,
                                                             shop_id: @shop.id)
    assert service.valid?
    assert_equal 1, MagazCore::User.count
  end

  test "should not delete user with invalid params" do
    assert_equal 2, MagazCore::User.count
    service = MagazCore::AdminServices::User::DeleteUser.run(id: "",
                                                             shop_id: "")
    refute service.valid?
    assert_equal 2, MagazCore::User.count
    assert_equal "Id is not a valid integer", service.errors.full_messages.first
    assert_equal "Shop is not a valid integer", service.errors.full_messages.last
  end

  test "should not delete shop owner" do
    assert_equal 2, MagazCore::User.count
    service = MagazCore::AdminServices::User::DeleteUser.run(id: @shop_owner.id,
                                                             shop_id: @shop.id)
    refute service.valid?
    assert_equal 2, MagazCore::User.count
    assert_equal "Can't delete shop owner.", service.errors.full_messages.first
  end
end