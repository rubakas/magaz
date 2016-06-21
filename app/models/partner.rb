class Partner < ApplicationRecord

  has_many :themes, dependent: :destroy
  has_many :theme_styles, through: :themes
  
end
