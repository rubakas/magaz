require 'test_helper'

module MagazCore
  class Services::ThemeSystemTest < ActiveSupport::TestCase
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

    test 'activate_theme' do
      install_service = MagazCore::ThemeServices::Install
                          .call(shop_id: @shop.id, 
                                source_theme_id: @theme.id, 
                                installed_theme_id: nil)
      
      activate_service = MagazCore::ThemeServices::Activate
                          .call(shop_id: @shop.id, 
                                installed_theme_id: install_service.installed_theme.id)

      assert @shop.themes.with_role('main').first == install_service.installed_theme
    end
  end
end