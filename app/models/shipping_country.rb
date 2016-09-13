class ShippingCountry < ActiveRecord::Base

  COUNTRY_LIST = YAML.load_file("#{Rails.root}/config/countries.yml")

  belongs_to  :shop
  has_many    :shipping_rates, dependent: :destroy
  has_many    :tax_overrides

  validates :name,
            presence: true,
            inclusion: ShippingCountry::COUNTRY_LIST['countries'].keys,
            uniqueness: { scope: :shop }
  validates :shop_id, presence: true
  validates :tax, numericality: true, presence: true

  def country_info
    COUNTRY_LIST['countries'][self.name]
  end
end
