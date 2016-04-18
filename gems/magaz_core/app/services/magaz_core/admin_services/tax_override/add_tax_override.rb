class MagazCore::AdminServices::TaxOverride::AddTaxOverride < ActiveInteraction::Base

  float :rate
  integer :collection_id, default: nil
  integer :shipping_country_id
  boolean :is_shipping

  validates :rate, :shipping_country_id, presence: true

  validate :if_shipping
  validate :check_for_uniqueness
  validate :check_method
  validate :check_collection_id

  def execute
    tax_override = MagazCore::TaxOverride.new(@params)
    errors.merge!(tax_override.errors) unless tax_override.save

    tax_override
  end

  private

  def check_collection_id
    @params[:collection_id] = nil if collection_id == 0

    errors.add(:base,
               I18n.t('services.add_tax_override.wrong_params')) if is_shipping == false &&
                                                                    @params[:collection_id] == nil
  end

  def if_shipping
    @params = inputs
    @params[:collection_id] = nil if is_shipping == true
  end

  def check_for_uniqueness
    shipping_country = MagazCore::ShippingCountry.find_by_id(shipping_country_id)
    if is_shipping == false
      override = shipping_country.tax_overrides.find_by(collection_id: collection_id)
    else
      override = shipping_country.tax_overrides.find_by(is_shipping: true)
    end
    unless override == nil
      errors.add(:base, I18n.t('services.add_tax_override.already_exists'))
    end
  end

  def check_method
    errors.add(:base,
               I18n.t('services.add_tax_override.wrong_params')) if is_shipping == false &&
                                                                    collection_id == nil
  end
end
