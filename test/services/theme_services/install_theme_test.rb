require 'test_helper'


class ThemeServices::InstallThemeTest < ActiveSupport::TestCase
  setup do
    @shop            = create(:shop)
    @source_theme    = build(:theme)
    archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
    import_service =
      ThemeServices::ImportFromArchive
      .new( archive_path:     archive_path,
            theme:            @source_theme,
            theme_attributes: @source_theme.attributes)
      .run

    fail import_service.theme.errors.inspect unless import_service.success?
    @theme = import_service.theme
  end

  test 'should install_theme with valid params and theme in system' do
    service = ThemeServices::InstallTheme
              .new( shop_id:          @shop.id,
                    source_theme_id:  @theme.id)
              .run

    assert service.success?
    assert_not_nil service.result.name
    assert_equal @source_theme.name, service.result.name
    assert service.result.kind_of?(Theme)
    assert @shop.themes.installed.include?(service.result)
  end

  # TODO: check this logic
  # test 'should not install_theme with invalid shop_id' do
  #   service = ThemeServices::InstallTheme.new(shop_id: 111,
  #                                             source_theme_id: @theme.id)
  #                                        .run
  #   refute service.success?
  #   assert_equal 1, service.result.errors.full_messages.count
  #   assert_equal "Can't find shop with such id", service.result.errors.full_messages.last
  # end

end
