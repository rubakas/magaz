class Partner < ApplicationRecord
  has_many :themes

  validetes :name, presence: true, uniqueness: true
end
