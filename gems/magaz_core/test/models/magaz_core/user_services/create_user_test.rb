require 'test_helper'

module MagazCore
  class UserServices::CreateUserTest < ActiveSupport::TestCase
    setup do
      @default_theme = build(:theme)
      archive_path = ::File.expand_path('./../../../../fixtures/files/valid_theme.zip', __FILE__)
      MagazCore::ThemeServices::ImportFromArchive
        .call(archive_path: archive_path,
              theme: @default_theme,
              theme_attributes: { name: 'Default' })
      @user_params = { first_name: 'First' , last_name: 'Last', email: 'email@mail.com', password: 'password' }
      @shop = create(:shop)
    end

    test 'should create user with valid params' do
      service = MagazCore::UserServices::CreateUser.call(user_params: @user_params, shop: @shop)
      assert service.user.persisted?
      assert_equal service.user.first_name, 'First'
      assert_equal service.user.last_name, 'Last'
      assert_equal service.user.email, 'email@mail.com'
      assert_equal service.user.password, 'password'
    end

    test 'fail user creation when no user params' do
      service = MagazCore::UserServices::CreateUser
                  .call(user_params: {}, shop: @shop)
      refute service.user.persisted?
    end
  end
end