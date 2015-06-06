module MagazCore
  class ShippingCountry < ActiveRecord::Base
    self.table_name = 'shipping_countries'

    belongs_to :shop
    has_many   :shipping_rates, dependent: :destroy
    has_many :tax_overrides

    validates :tax, :name, presence: true
    validates :tax, numericality: true
    validates :name, uniqueness: { scope: :shop_id }

    COUNTRY_LIST = YAML.load_file("#{MagazCore::Engine.root}/config/countries.yml")

    def country_info
      COUNTRY_LIST['countries'][self.name]
    end
  end
end