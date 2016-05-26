class Partner < ApplicationRecord
  
  has_many :themes

  validates :name, presence: true, uniqueness: true
end
