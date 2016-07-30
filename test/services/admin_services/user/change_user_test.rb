require 'test_helper'

class AdminServices::User::ChangeUserTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "Shop name")
    @user = create(:user, shop: @shop)
    @second_user = create(:user, shop: @shop)
    @success_params = { first_name: "New first_name", last_name: "New last_name",
                        email: "new@email.com", password: "newpassazazaz", permissions: ['God', 'Mode'] }
    @blank_params = { first_name: "", last_name: "",
                      email: "", password: "", permissions: ""}
  end

  test "should update user with valid params" do
    assert User.find(@user.id)
    service = AdminServices::User::ChangeUser
              .new(id: @user.id, shop_id: @shop.id, params: @success_params)
              .run
    assert service.success?
    assert_equal "New first_name", User.find(@user.id).first_name
    assert_equal "new@email.com", User.find(@user.id).email
  end

  test "should not update user with blank params" do
    service = AdminServices::User::ChangeUser
              .new(id: @user.id, shop_id: @shop.id, params: @blank_params)
              .run
    refute service.success?
    assert_equal 4, service.result.errors.full_messages.count
  end

  test "should update user with some blank params" do
    assert User.find(@user.id)
    some_blank_params = @success_params.merge({ password: "", permissions: nil })
    service = AdminServices::User::ChangeUser
              .new(id: @user.id, shop_id: @shop.id, params: some_blank_params)
              .run
    assert service.success?
    assert_equal some_blank_params[:first_name], User.find(@user.id).first_name
    assert_equal some_blank_params[:email], User.find(@user.id).email
  end

  test "should not update user with existing email" do
    invalid_params =  @success_params.merge({ email: @second_user.email })
    service = AdminServices::User::ChangeUser
              .new(id: @user.id, shop_id: @shop.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Email has already been taken", service.result.errors.full_messages.first
  end

  test "should not update user with invalid email" do
    invalid_params =  @success_params.merge({ email: "email" })
    service = AdminServices::User::ChangeUser
              .new(id: @user.id, shop_id: @shop.id, params: invalid_params)
              .run
    refute service.success?
    assert_equal 1, service.result.errors.full_messages.count
    assert_equal "Email is invalid", service.result.errors.full_messages.first
  end
end
