require 'test_helper'

module MagazCore
  class Services::ThemeSystem::ArchiveImporterTest < ActiveSupport::TestCase

    test 'imports from valid archive' do
      archive_path = File.expand_path('./../../../../../fixtures/files/valid_theme.zip', __FILE__)
      theme = Theme.new
      theme_attributes = {}
      archive_importer = 
        Services::ThemeSystem::ArchiveImporter.new archive_path: archive_path, 
                                                   theme: theme,
                                                   theme_attributes: theme_attributes
      archive_importer.import
      assert_kind_of Theme, archive_importer.theme
      assert archive_importer.theme.valid?
      assert archive_importer.theme.persisted?
    end
  end
end