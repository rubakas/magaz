require 'test_helper'

module MagazCore
  class ThemeTest < ActiveSupport::TestCase

    setup do
      @shop = create(:shop)
      @source_theme = build(:theme)
      @archive_path = File.expand_path('./../../../fixtures/files/valid_theme.zip', __FILE__)
      
      MagazCore::ThemeServices::ImportFromArchive
        .call(archive_path: @archive_path, 
              theme: @source_theme,
              theme_attributes: { name: 'Default' })

      service = MagazCore::ThemeServices::Install
                  .call(shop_id: @shop.id, 
                        source_theme_id: @source_theme.id)

      @installed_theme = service.installed_theme
    end

    test 'self referencing association' do
      assert_equal @source_theme, @installed_theme.source_theme
      assert_includes @source_theme.installed_themes, @installed_theme
    end

    test 'finder of source associations' do
      assert_includes Theme.sources, @source_theme
      refute_includes Theme.sources, @installed_theme
    end

    test 'with_role finder' do
      foo_theme = build(:theme, role: 'foo')
      MagazCore::ThemeServices::ImportFromArchive
        .call(archive_path: @archive_path, 
              theme: foo_theme,
              theme_attributes: { name: 'Foo' })

      assert 1 == Theme.with_role('foo').length
    end

  end
end