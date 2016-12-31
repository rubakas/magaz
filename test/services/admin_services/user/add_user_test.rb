require 'test_helper'

class AdminServices::User::AddUserTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop, name: "Shop name")
    @user = create(:user, shop: @shop)
    @success_params = { 'first_name' => "New first_name",
                        'last_name' => "New last_name",
                        'email'     => "new@email.com",
                        'password'  => "newpassazazaz",
                        'account_owner' => true,
                        'permissions' => ['God', 'Mode'] }

    @blank_params = {}
  end

  test "should create user with valid params" do
    service = AdminServices::User::AddUser
              .new(shop_id: @shop.id, params: @success_params)
              .run
    assert service.success?

    assert_equal 2, User.count
    assert_equal "New first_name", service.result.first_name
    assert_equal "New last_name", service.result.last_name
    assert_equal "new@email.com", service.result.email
  end

  test "should create user with some blank params" do
    @success_params['permissions'] = nil
    service = AdminServices::User::AddUser.new(shop_id: @shop.id, params: @success_params).run
    assert service.success?
    assert_equal @success_params['first_name'], service.result.first_name
    assert_equal @success_params['email'], service.result.email
  end

end
