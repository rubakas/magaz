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

class ThemeTest < ActiveSupport::TestCase

  setup do
    @shop = create(:shop)
    @source_theme = build(:theme)
    @archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)

    ThemeServices::ImportFromArchive
      .call(archive_path: @archive_path,
            theme: @source_theme,
            theme_attributes: { name: 'Default' })

    service = ThemeServices::InstallTheme
                .run(shop_id: @shop.id,
                     source_theme_id: @source_theme.id)

    @installed_theme = service.result
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
end
