class ThemeServices::CreateThemeStyles < ActiveInteraction::Base

  integer :theme_id
  string :archive_path

  validates :archive_path, :theme_id, presence: true

  def execute
    theme = Theme.find(theme_id)
    @saved_theme_styles = []
    path_to_settings_data = "#{archive_path}/config/settings_data.json"
    json_file = File.read(path_to_settings_data)
    settings = JSON.parse(json_file)
    key = settings.keys.last # key = "presets"
    theme_styles = settings[key]
    unless theme_styles.empty?
      theme_styles.each_key do |theme_style_name|
        theme_style = theme.theme_styles.create!(name: theme_style_name)
        @saved_theme_styles << theme_style
      end
    else
      errors.add(:base, I18n.t('services.create_theme_styles.no_styles'))
      raise ActiveRecord::RecordInvalid
    end
    @saved_theme_styles
  end

end
