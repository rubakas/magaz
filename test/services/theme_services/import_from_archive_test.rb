require 'test_helper'


class ThemeServices::ImportFromArchiveTest < ActiveSupport::TestCase

  setup do
    @archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
    @invalid_archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/invalid_theme.zip", __FILE__)
    @theme = Theme.new
    @theme_attributes = { name: "New thmee", price: 70, industry: "Other"}
  end

  test 'imports from valid archive' do
    assert_equal 0, Theme.count
    assert_equal 0, ThemeStyle.count
    archive_importer =
      ThemeServices::ImportFromArchive.call archive_path: @archive_path,
                                                       theme: @theme,
                                                       theme_attributes: @theme_attributes
    assert_kind_of Theme, archive_importer.theme
    assert archive_importer.theme.valid?
    assert archive_importer.theme.persisted?
    assert_equal @theme_attributes[:name], archive_importer.theme.name
    assert_equal @theme_attributes[:price], archive_importer.theme.price
    assert_equal @theme_attributes[:industry], archive_importer.theme.industry
    assert_equal 1, Theme.count
    assert_equal 1, archive_importer.theme.theme_styles.count
    assert_equal "Default", archive_importer.theme.theme_styles.first.name
  end

  test "should not create theme and style when theme hasn't any theme"  do
    assert_equal 0, Theme.count
    assert_equal 0, ThemeStyle.count
    archive_importer =
      ThemeServices::ImportFromArchive.call archive_path: @invalid_archive_path,
                                                       theme: @theme,
                                                       theme_attributes: @theme_attributes
    assert_equal 0, Theme.count
    assert_equal 0, ThemeStyle.count
  end
  
end
