# == Schema Information
#
# Table name: themes
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime
#  updated_at      :datetime
#  shop_id         :integer
#  source_theme_id :integer
#  role            :string
#

require 'test_helper'

module MagazCore
  class ThemeTest < ActiveSupport::TestCase

    should have_many(:assets)
    should have_many(:installed_themes)
    should belong_to(:shop)
    should belong_to(:source_theme)

    setup do
      @shop = create(:shop)
      @source_theme = build(:theme)
      @archive_path = ::File.expand_path('./../../../fixtures/files/valid_theme.zip', __FILE__)

      MagazCore::ThemeServices::ImportFromArchive
        .call(archive_path: @archive_path,
              theme: @source_theme,
              theme_attributes: { name: 'Default' })

      service = MagazCore::ThemeServices::Install
                  .call(shop_id: @shop.id,
                        source_theme_id: @source_theme.id)

      @installed_theme = service.installed_theme


      @unpublished_theme = build(:theme, role: Theme::Roles::UNPUBLISHED)
      @main_theme = build(:theme, role: Theme::Roles::MAIN)


      MagazCore::ThemeServices::ImportFromArchive
        .call(archive_path: @archive_path,
              theme: @unpublished_theme,
              theme_attributes: { name: 'Default' })


      MagazCore::ThemeServices::ImportFromArchive
        .call(archive_path: @archive_path,
              theme: @main_theme,
              theme_attributes: { name: 'Default' })
    end

    test '#activate!' do
      @source_theme.activate!
      @source_theme.reload
      assert_equal @source_theme.role, Theme::Roles::MAIN
    end

    test '#deactivate!' do
      @source_theme.deactivate!
      @source_theme.reload
      assert_equal @source_theme.role, Theme::Roles::UNPUBLISHED
    end

    test 'validates default directories presence' do
    end

    test 'validates default layout presence' do
    end

    test 'validates default templates presence' do
    end

    test 'validates default config presence' do
    end

    test 'self referencing association' do
      assert_equal @source_theme, @installed_theme.source_theme
      assert_includes @source_theme.installed_themes, @installed_theme
    end

    test 'finder of source associations' do
      assert_includes Theme.sources, @source_theme
      refute_includes Theme.sources, @installed_theme
    end

    test "scope sources" do
      assert_equal @source_theme, MagazCore::Theme.sources.find_by_id(@source_theme.id)
    end

    test "scope installed" do
      assert_equal @installed_theme, MagazCore::Theme.installed.find_by_id(@installed_theme.id)
    end

    test "scope main" do
      assert_equal @main_theme, MagazCore::Theme.main
    end

    test "scope unpublished" do
      assert_equal @unpublished_theme, MagazCore::Theme.unpublished.find_by_id(@unpublished_theme.id)
    end
  end
end
