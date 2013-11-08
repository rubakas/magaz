class Page < ActiveRecord::Base
  belongs_to :shop

  validates :name,
    presence: true,
    uniqueness: { scope: :shop_id }
end