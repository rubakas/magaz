require 'test_helper'

module MagazCore
  class ThemeServices::InstallTest < ActiveSupport::TestCase
    setup do
      @shop            = create(:shop)
      @source_theme    = build(:theme)
      archive_path = File.expand_path('./../../../../fixtures/files/valid_theme.zip', __FILE__)
      import_service = MagazCore::ThemeServices::ImportFromArchive
                        .call(archive_path: archive_path, 
                              theme: @source_theme,
                              theme_attributes: @source_theme.attributes)
      @theme = import_service.theme
    end

    test 'install_theme' do
      service = MagazCore::ThemeServices::Install
                  .call(shop_id: @shop.id, 
                        source_theme_id: @theme.id, 
                        installed_theme_id: nil)
      assert service.installed_theme.kind_of?(Theme)
      assert @shop.themes.installed.include?(service.installed_theme)
    end

  end
end