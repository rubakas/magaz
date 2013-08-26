class Collection < ActiveRecord::Base
  belongs_to :shop

  validates :name, presence: true, uniqueness: { scope: :shop_id }
  validates :description, presence: true
end
