class Partner < ApplicationRecord

  has_many :themes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :website_url, presence: true, uniqueness: true
  
end
