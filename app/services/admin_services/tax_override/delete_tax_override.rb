class MagazCore::AdminServices::TaxOverride::DeleteTaxOverride < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute 
    MagazCore::TaxOverride.find(id).destroy
  end

end