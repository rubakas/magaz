require 'zip'
require 'zip/filesystem'
require 'tempfile'

module ThemeServices
  class ImportFromArchive
    include Concerns::Service
    attr_accessor :theme

    def call(archive_path:, theme:, theme_attributes: {})
      @theme = theme

      tmp_path = _create_tmp_path
      begin
        _unpack_archive(archive_path: archive_path, unpack_path: tmp_path)
        root_path = _resolve_root_path(tmp_path)

        _build_associated_assets_from_path(theme: theme, path: root_path)

        create_style(theme: theme, path: root_path) 
        set_attributes(theme, theme_attributes)
        
        theme.save # run validations
      rescue RuntimeError
        @theme.errors.add(:base, I18n.t('services.import_from_archive.no_styles'))
      ensure
        # remove the directory.
        _delete_tmp_path(tmp_path)
      end
    end

    private

    def set_attributes(theme, attributes)
      theme.name = attributes[:name]
      theme.price = attributes[:price]
      theme.industry = attributes[:industry]
      theme.partner_id = attributes[:partner_id]
    end

    def create_style(theme:, path:)

      path_to_settings_data = "#{path}/config/settings_data.json"
      json_file = File.read(path_to_settings_data)
      settings = JSON.parse(json_file)
      key = settings.keys.last # key = "presets"
      theme_styles = settings[key]
      unless theme_styles.empty?
        theme_styles.each_key do |style_name|
          theme.theme_styles.build(name: style_name)
        end
      else
        raise RuntimeError.new()
      end

    end

    def _build_associated_assets_from_path(theme:, path:)
      Dir.glob("#{path}/**/*") do |current_path|
        unless ::File.directory?(current_path)
          # we don't need full path as a key
          current_relative_path = current_path.sub("#{path}/", "")
          asset_attributes = { key: current_relative_path }
          theme.assets.build asset_attributes
        end
      end

    end

    def _create_tmp_path
      tmp_dir = Dir.mktmpdir
      tmp_dir
    end

    def _delete_tmp_path(path)
      FileUtils.remove_entry path
    end

    def _resolve_root_path(path)
      file_names = Dir.glob(::File.expand_path('*', path))
      dir_names = file_names.select do |file_name|
        ::File.directory?(::File.expand_path(file_name, path))
      end

      if 1 == dir_names.length
        dir_names[0]
      else
        path
      end
    end

    def _unpack_archive(archive_path:, unpack_path:)
      Zip::File.open(archive_path) do |zip_file|
        zip_file.each do |current_file|
          # do not extract OS X trash files
          next if current_file.name =~ /__MACOSX/ || current_file.name =~ /\.DS_Store/

          f_path = ::File.join(unpack_path, current_file.name)
          FileUtils.mkdir_p(::File.dirname(f_path))
          zip_file.extract(current_file, f_path)
        end
      end
    end

  end
end
