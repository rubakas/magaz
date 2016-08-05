class ThemeServices::CreateThemeStyles

  attr_reader :success, :result, :errors
  alias_method :success?, :success

  def initialize(archive_path:, theme_id:)
    @theme = Theme.find(theme_id)

    path_to_settings_data = "#{archive_path}/config/settings_data.json"
    json_file = File.read(path_to_settings_data)

    @settings = JSON.parse(json_file)
    @result = []
    @errors = []
    @success = true
  end

  def run
    key = @settings.keys.last # key = "presets"
    theme_styles = @settings[key]
    if theme_styles.empty?
      @errors << I18n.t('services.create_theme_styles.no_styles')
      @success = false
      raise ActiveRecord::RecordInvalid
    else
      theme_styles.each_key do |theme_style_name|
        theme_style = @theme.theme_styles.create!(name: theme_style_name)
        @result << theme_style
      end
    end
    self
  end

end
