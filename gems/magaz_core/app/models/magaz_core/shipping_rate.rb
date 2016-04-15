module MagazCore
  class ShippingRate < ActiveRecord::Base
    self.table_name = 'shipping_rates'

    belongs_to :shipping_country

    # validates_presence_of :name, :shipping_price
    # validates_numericality_of :price_from,     allow_blank: true
    # validates_numericality_of :price_to,       allow_blank: true
    # validates_numericality_of :weight_from,    allow_blank: true
    # validates_numericality_of :weight_to,      allow_blank: true
    # validates_numericality_of :shipping_price, allow_blank: true


    # validate :price_criteria_check
    # validate :weight_criteria_check
    # validate :price_comparison_check, :weight_comparison_check

    private

    def price_criteria_check
      if price_from.present? && price_to.present? && criteria == "weight" && !weight_from.present? && !weight_to.present?
        errors.add(:criteria, I18n.t('default.models.shipping_rate.not_correct'))
      else
        return
      end
    end

    def weight_criteria_check
      if weight_from.present? && weight_to.present? && criteria == "price" && !price_from.present? && !price_to.present?
        errors.add(:criteria, I18n.t('default.models.shipping_rate.not_correct'))
      else
        return
      end
    end

    def price_comparison_check
      if price_to.present? && price_from.present? && price_to < price_from
        errors.add(:price_to, I18n.t('default.models.shipping_rate.price_to_must_be_greater'))
      else
        return
      end
    end

    def weight_comparison_check
      if weight_from.present? && weight_to.present? && weight_to < weight_from
        errors.add(:weight_to, I18n.t('default.models.shipping_rate.weight_to_must_be_greater'))
      else
        return
      end
    end

  end
end
