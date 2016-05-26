class ThemeServices::CreateThemeStyle < ActiveInteraction::Base

  set_callback :validate, :after, -> {theme_style}

  integer :theme_id
  string :name
  string :image, default: nil

  validates :name, :theme_id, presence: true
  validate :name_uniqueness

  def theme_style
    @theme_style = ThemeStyle.new
    add_errors if errors.any?
    @theme_style
  end

  def execute
    unless @theme_style.update_attributes(inputs)
      errors.merge!(@theme_style.errors)
    end
    @theme_style
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @theme_style.errors.add(:base, msg)
    end
  end

  def name_uniqueness
    errors.add(:base, I18n.t('services.create_theme_style.name_not_unique')) unless name_unique?
  end

  def name_unique?
    ThemeStyle.where(theme_id: theme_id, name: name).count == 0
  end

end
