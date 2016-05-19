class AdminServices::ShippingCountry::DeleteShippingCountry < ActiveInteraction::Base

  integer :id, :shop_id

  validates :id, :shop_id, presence: true

  def execute
    Shop.find(shop_id).shipping_countries.find(id).destroy
  end

end
