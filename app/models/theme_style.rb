class ThemeStyle < ApplicationRecord

  belongs_to :theme

  validates :name, uniqueness: { scope: :theme_id }
  
end
