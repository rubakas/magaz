class AdminServices::ShippingRate::DeleteShippingRate < ActiveInteraction::Base

  integer :id, :shipping_country_id

  validates :id, :shipping_country_id, presence: true

  def shipping_country
    ShippingCountry.find(shipping_country_id)
  end

  def execute
    ShippingCountry.find(shipping_country_id).shipping_rates.find(id).destroy
  end

end
