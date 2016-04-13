class MagazCore::AdminServices::Shop::ChangeTaxesSettings < ActiveInteraction::Base

  boolean :all_taxes_are_included, :charge_taxes_on_shipping_rates, default: false
  integer :id

  validates :id, presence: true

  def execute
    shop = MagazCore::Shop.find(id)
    shop.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('default.services.wrong_params',
                               model: I18n.t('default.services.shop')))

    shop
  end

end