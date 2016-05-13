require 'test_helper'

class AdminServices::User::AddUserTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "Shop name")
    @user = create(:user, shop: @shop)
    @success_params = {first_name: "New first_name",
                       shop_id: @shop.id,
                       last_name: "New last_name",
                       email: "new@email.com",
                       password: "newpassazazaz",
                       account_owner: true,
                       permissions: ['God', 'Mode']}
    @blank_params = {first_name: "",
                     shop_id: '',
                     last_name: "",
                     email: "",
                     password: "",
                     account_owner: '',
                     permissions: ""}
  end

  test "should create user with valid params" do
    service = AdminServices::User::AddUser.run(@success_params)
    assert service.valid?
    assert_equal 2, User.count
    assert_equal "New first_name", service.result.first_name
    assert_equal "New last_name", service.result.last_name
    assert_equal "new@email.com", service.result.email
  end

  test "should not create user with blank params" do
    service = AdminServices::User::AddUser.run(@blank_params)
    refute service.valid?
    assert_equal 3, service.errors.full_messages.count
    assert_equal "Shop is not a valid integer", service.errors.full_messages.first
    assert_equal "Permissions is not a valid array", service.errors.full_messages[1]
    assert_equal "Account owner is not a valid boolean", service.errors.full_messages.last
  end

  test "should create user with some blank params" do
    @success_params[:permissions] = nil
    service = AdminServices::User::AddUser.run(@success_params)
    assert service.valid?
    assert_equal @success_params[:first_name], service.result.first_name
    assert_equal @success_params[:email], service.result.email
  end

  test "should not create user with existing email" do
    @success_params[:email] = @user.email
    service = AdminServices::User::AddUser.run(@success_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Email is already been taken", service.errors.full_messages.first
  end

  test "should not create user with invalid email" do
    @success_params[:email] = "email"
    service = AdminServices::User::AddUser.run(@success_params)
    refute service.valid?
    assert_equal 1, service.errors.full_messages.count
    assert_equal "Email is not valid", service.errors.full_messages.first
  end
end
