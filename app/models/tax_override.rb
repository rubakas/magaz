class TaxOverride < ActiveRecord::Base
  belongs_to :collection
  belongs_to :shipping_country
  validates :rate, presence: true

  validate :check_collection_unless_shipping
  validates :is_shipping, uniqueness: { scope: :shipping_country }, if: :is_shipping
  validates :collection_id, uniqueness: { scope: :shipping_country }, unless: :is_shipping

  def check_collection_unless_shipping
    errors.add(:base, I18n.t('services.add_tax_override.wrong_params')) if !is_shipping && collection_id.nil?
  end

end
