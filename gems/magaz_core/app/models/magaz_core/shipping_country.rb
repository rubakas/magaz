module MagazCore
  class ShippingCountry < ActiveRecord::Base
    self.table_name = 'shipping_countries'

    belongs_to :shop
    belongs_to :country
    has_many   :shipping_rates, dependent: :destroy
    has_many :tax_overrides

    validates :tax, :name, presence: true
    validates :tax, numericality: true
    validates :name, uniqueness: { scope: :shop_id }
  end
end