module MagazCore
  class Country < ActiveRecord::Base
    self.table_name = 'countries'

    belongs_to :shop
    has_many   :shipping_rates

    accepts_nested_attributes_for :shipping_rates

    validates :code, presence: true, uniqueness: { scope: :shop_id }
    validates :tax, presence: true
  end
end