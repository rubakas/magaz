require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @registration = create(:shop)
    @default_theme = build(:theme)
    archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
    ThemeServices::ImportFromArchive
      .call(archive_path: archive_path,
            theme: @default_theme,
            theme_attributes: { name: 'Default' })
  end
end
