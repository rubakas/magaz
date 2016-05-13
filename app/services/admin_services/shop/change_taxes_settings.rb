class AdminServices::Shop::ChangeTaxesSettings < ActiveInteraction::Base

  set_callback :validate, :after, -> {shop}

  boolean :all_taxes_are_included, :charge_taxes_on_shipping_rates, default: false
  integer :id
  string :charge_vat_taxes, default: nil

  validates :id, presence: true

  def shop
    @shop = Shop.find(id)
    add_errors if errors.any?
    @shop
  end

  def execute
    @shop.update_attributes!(shop_params) ||
      errors.add(:base, I18n.t('services.shop_services.wrong_params'))

    @shop
  end

  private

  def shop_params
    params = inputs.slice!(:id, :charge_vat_taxes)
    params[:eu_digital_goods_collection_id] = nil unless charge_vat_taxes == 'charge_vat_taxes'

    params
  end

  def add_errors
    errors.full_messages.each do |msg|
      @shop.errors.add(:base, msg)
    end
  end

end
