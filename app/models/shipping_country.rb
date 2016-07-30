class ShippingCountry < ActiveRecord::Base

  COUNTRY_LIST = YAML.load_file("#{Rails.root}/config/countries.yml")

  belongs_to  :shop
  has_many    :shipping_rates, dependent: :destroy
  has_many    :tax_overrides

  validates :tax, numericality: true
  validates :tax, :name, :shop_id, presence: true
  validates :name, inclusion: ShippingCountry::COUNTRY_LIST['countries'].keys
  validates :name, uniqueness: { scope: :shop }

  def country_info
    COUNTRY_LIST['countries'][self.name]
  end
end
