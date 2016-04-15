class MagazCore::AdminServices::TaxOverride::ChangeTaxOverride < ActiveInteraction::Base

  integer :id, :collection_id, :shipping_country_id
  float :rate
  boolean :is_shipping, default: false

  validates :id, :rate, :shipping_country_id, presence: true

  def execute
    tax_override = MagazCore::TaxOverride.find(id)
    tax_override.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_tax_override.wrong_params'))

    tax_override
  end

end
