require 'zip'
require 'zip/filesystem'
require 'tempfile'

module MagazCore
  class Services::ThemeSystem::ArchiveImporter
    attr_accessor :theme

    def initialize(archive_path:, theme:, theme_attributes: {})
      @archive_path = archive_path
      @theme = theme
      @theme_attributes = theme_attributes
    end

    def import
      # create temporary directory
      tmp_path = _create_tmp_path
      begin
        _unpack_archive(archive_path: @archive_path, unpack_path: tmp_path)
        root_path = _resolve_root_path(tmp_path)
        
        _build_associated_assets_from_path(theme: theme, path: root_path)
        theme.save # run validations
      ensure
        # remove the directory.
        _delete_tmp_path(tmp_path)
      end
    end

    private

    def _build_associated_assets_from_path(theme:, path:)
      asset_attributes = {}
      theme.assets.build(asset_attributes)
    end

    def _create_tmp_path
      tmp_dir = Dir.mktmpdir
      tmp_dir
    end

    def _delete_tmp_path(path)
      FileUtils.remove_entry path
    end

    def _resolve_root_path(path)
      fail path
    end

    def _unpack_archive(archive_path:, unpack_path:)
      Zip::File.open(archive_path) do |zip_file|
        zip_file.each do |f|
          # do not extract OS X trash files
          next if zip_file.name =~ /__MACOSX/ or zip_file.name =~ /\.DS_Store/

          f_path=File.join(unpack_path, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path)
        end
      end
    end

  end
end