class MagazCore::AdminServices::TaxOverride::DeleteTaxOverride < ActiveInteraction::Base

  integer :id, :shipping_country_id

  validates :id, :shipping_country_id, presence: true

  def execute 
    MagazCore::ShippingCountry.find(shipping_country_id).tax_overrides.find(id).destroy
  end

end