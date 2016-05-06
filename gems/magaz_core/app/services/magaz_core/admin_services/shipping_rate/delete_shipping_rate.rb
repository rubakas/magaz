class MagazCore::AdminServices::ShippingRate::DeleteShippingRate < ActiveInteraction::Base

  integer :id, :shipping_country_id

  validates :id, :shipping_country_id, presence: true

  def shipping_country
    MagazCore::ShippingCountry.find(shipping_country_id)
  end

  def execute
    MagazCore::ShippingCountry.find(shipping_country_id).shipping_rates.find(id).destroy
  end

end