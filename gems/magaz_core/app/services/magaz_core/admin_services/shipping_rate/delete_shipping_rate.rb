class MagazCore::AdminServices::ShippingRate::DeleteShippingRate < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    MagazCore::ShippingRate.find(id).destroy
  end

end