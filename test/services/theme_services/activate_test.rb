require 'test_helper'

class ThemeServices::ActivateTest < ActiveSupport::TestCase
  setup do
    @shop            = create(:shop)
    @source_theme    = build(:theme)
    archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
    import_service = ThemeServices::ImportFromArchive
                      .call(archive_path:     archive_path,
                            theme:            @source_theme,
                            theme_attributes: @source_theme.attributes)
    @theme = import_service.theme
  end

  test 'activate_theme' do
    install_service = ThemeServices::InstallTheme
                      .run(shop_id:          @shop.id,
                           source_theme_id:  @theme.id)

    activate_service =  ThemeServices::Activate
                        .run( shop_id:            @shop.id,
                              installed_theme_id: install_service.result.id)

    assert_equal @shop.themes.main, install_service.result
  end

end
