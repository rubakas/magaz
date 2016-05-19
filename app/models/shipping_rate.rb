class ShippingRate < ActiveRecord::Base
  self.table_name = 'shipping_rates'

  belongs_to :shipping_country
end
