class ShippingRate < ActiveRecord::Base
  belongs_to :shipping_country
  validates :name, :shipping_price, :shipping_country_id, :criteria, presence: true

  validates :shipping_price, :price_from, :price_to, :weight_from, :weight_to, number: true, allow_blank: true

  validate :price_criteria_check, :weight_criteria_check, :price_comparison_check, :weight_comparison_check

  def price_criteria_check
    if price_from.present? && price_to.present? && criteria == "weight" && weight_from.nil? && weight_to.nil?
      errors.add(:base, I18n.t('services.add_shipping_rate.not_correct'))
    end
  end

  def weight_criteria_check
    if weight_from.present? && weight_to.present? && criteria == "price" && price_from.nil? && price_to.nil?
      errors.add(:base, I18n.t('services.add_shipping_rate.not_correct'))
    end
  end

  def price_comparison_check
    if price_to.present? && price_from.present? && price_to < price_from
      errors.add(:base, I18n.t('services.add_shipping_rate.price_to_must_be_greater'))
    end
  end

  def weight_comparison_check
    if weight_from.present? && weight_to.present? && weight_to < weight_from
      errors.add(:base, I18n.t('services.add_shipping_rate.weight_to_must_be_greater'))
    end
  end
end
