class ShippingCountry < ActiveRecord::Base
  self.table_name = 'shipping_countries'

  COUNTRY_LIST = YAML.load_file("#{Rails.root}/config/countries.yml")

  belongs_to :shop
  has_many   :shipping_rates, dependent: :destroy
  has_many :tax_overrides

  def country_info
    COUNTRY_LIST['countries'][self.name]
  end
end
