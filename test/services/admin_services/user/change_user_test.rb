require 'test_helper'

class AdminServices::User::ChangeUserTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "Shop name")
    @user = create(:user, shop: @shop)
    @second_user = create(:user, shop: @shop)
    @success_params = {id: @user.id,
                      first_name: "New first_name",
                      last_name: "New last_name",
                      email: "new@email.com",
                      password: "newpassazazaz",
                      permissions: ['God', 'Mode'],
                      shop_id: @shop.id}
    @blank_params = {id: @user.id,
                     shop_id: @shop.id,
                     first_name: "",
                     last_name: "",
                     email: "",
                     password: "",
                     permissions: ""}
  end

  test "should update user with valid params" do
    assert User.find(@user.id)
    service = AdminServices::User::ChangeUser.run(@success_params)
    assert service.valid?
    assert_equal "New first_name", User.find(@user.id).first_name
    assert_equal "new@email.com", User.find(@user.id).email
  end

  test "should not update user with blank params" do
    service = AdminServices::User::ChangeUser.run(@blank_params)
    refute service.valid?
    assert_equal 1, service.user.errors.full_messages.count
    assert_equal "Permissions is not a valid array", service.user.errors.full_messages.last
  end

  test "should update user with some blank params" do
    assert User.find(@user.id)
    @success_params[:password] = ""
    @success_params[:permissions] = nil
    service = AdminServices::User::ChangeUser.run(@success_params)
    assert service.valid?
    assert_equal @success_params[:first_name], User.find(@user.id).first_name
    assert_equal @success_params[:email], User.find(@user.id).email
  end

  test "should not update user with existing email" do
    @success_params[:email] = @second_user.email
    service = AdminServices::User::ChangeUser.run(@success_params)
    refute service.valid?
    assert_equal 1, service.user.errors.full_messages.count
    assert_equal "Email is not valid or already has been taken", service.user.errors.full_messages.first
  end

  test "should not update user with invalid email" do
    @success_params[:email] = "email"
    service = AdminServices::User::ChangeUser.run(@success_params)
    refute service.valid?
    assert_equal 1, service.user.errors.full_messages.count
    assert_equal "Email is not valid or already has been taken", service.user.errors.full_messages.first
  end
end
