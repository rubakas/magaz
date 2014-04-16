class Theme < ActiveRecord::Base
  ROLES = %w[main unpublished]

  belongs_to :shop
  
  has_many   :installed_themes, class_name: 'Theme', foreign_key: :source_theme_id
  belongs_to :source_theme, class_name: 'Theme', foreign_key: :source_theme_id

  scope :sources, -> { where(source_theme: nil) }
  scope :with_role, ->(role) { where(role: role) }

  scope :current, -> { where(role: 'main').first }
end
