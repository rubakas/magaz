class AdminServices::TaxOverride::DeleteTaxOverride < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    TaxOverride.find(id).destroy
  end

end
