require 'test_helper'

module MagazCore
  class Services::ThemeSystemTest < ActiveSupport::TestCase
    setup do
      @shop            = create(:shop)
      @source_theme    = create(:theme)
      @service      = Services::ThemeSystem.new(shop_id: @shop.id, 
                                                source_theme_id: @source_theme.id)
    end

    test 'install_theme' do
      @service.install_theme
      assert @service.installed_theme.kind_of?(Theme)
      assert @shop.themes.installed.include?(@service.installed_theme)
    end

    test 'activate_theme' do
      new_source_theme = create(:theme)
      install_service = 
        Services::ThemeSystem.new(shop_id: @shop.id, source_theme_id: new_source_theme.id)
      install_service.install_theme
      installed_theme = install_service.installed_theme

      activate_service =
        Services::ThemeSystem.new(shop_id: @shop.id, 
                                  installed_theme_id: installed_theme.id)
      activate_service.activate_theme
      assert @shop.themes.with_role('main').first == installed_theme
    end
  end
end