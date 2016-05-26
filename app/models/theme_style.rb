class ThemeStyle < ApplicationRecord

  belongs_to :theme

  # validates :name, presence: true, uniqueness: { scope: :theme_id }
  # validates :theme_id, presence: true
  
end
