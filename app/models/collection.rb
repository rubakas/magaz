class Collection < ActiveRecord::Base
  belongs_to :shop

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
