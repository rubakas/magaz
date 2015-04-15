require 'test_helper'

module MagazCore
  class ShopServices::CreateTest < ActiveSupport::TestCase
    setup do
      @default_theme = build(:theme)
      archive_path = ::File.expand_path('./../../../../fixtures/files/valid_theme.zip', __FILE__)
      MagazCore::ThemeServices::ImportFromArchive
        .call(archive_path: archive_path,
              theme: @default_theme,
              theme_attributes: { name: 'Default' })
      @shop_params = { name: 'example42' }
      @user_params = { first_name: 'First' , last_name: 'Last', email: 'email@mail.com', password: 'password' }
    end

    test 'create shop with valid params' do
      service = MagazCore::ShopServices::Create
                  .call(shop_params: @shop_params, user_params: @user_params)
      assert service.shop.persisted?
      refute service.shop.themes.main.blank?
      assert_equal @default_theme, service.shop.themes.main.first.source_theme
    end

    test 'fail shop creation when no default theme in system' do
      @default_theme.delete
      service = MagazCore::ShopServices::Create
                  .call(shop_params: @shop_params, user_params: @user_params)
      refute service.shop.persisted?
    end

    test 'fail shop creation when no user params' do
      service = MagazCore::ShopServices::Create
                  .call(shop_params: @shop_params, user_params: {})
      refute service.shop.persisted?
    end

    test 'fail shop creation when no shop params' do
      service = MagazCore::ShopServices::Create
                  .call(shop_params: {}, user_params: @user_params)
      refute service.shop.persisted?
    end

    test "shop and user should have association" do
      service = MagazCore::ShopServices::Create.call(shop_params: @shop_params, user_params: @user_params)
      assert service.shop.persisted?
      assert_not service.shop.users.blank?

      service.shop.users.each do |user|
        assert user.shop_id == service.shop.id
      end
    end

    test 'default content created' do
      service = MagazCore::ShopServices::Create.call(shop_params: @shop_params, user_params: @user_params)
      assert service.shop.persisted?

      assert_equal service.shop.email_templates.length, 11
      assert_equal service.shop.collections.length, 1
      assert_equal service.shop.blogs.length, 1
      assert_equal service.shop.articles.length, 1
      assert_equal service.shop.pages.length, 2
      assert_equal service.shop.link_lists.length, 2
      assert_equal service.shop.links.length, 4
    end

  end
end