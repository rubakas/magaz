module MagazCore
  class ShippingRate < ActiveRecord::Base
    self.table_name = 'shipping_rates'

    belongs_to :country

    validates_presence_of :name, :shipping_price
    validates_numericality_of :price_from,     allow_blank: true
    validates_numericality_of :price_to,       allow_blank: true
    validates_numericality_of :weight_from,    allow_blank: true
    validates_numericality_of :weight_to,      allow_blank: true
    validates_numericality_of :shipping_price, allow_blank: true


    validate :price_criteria_check
    validate :weight_criteria_check
    validate :price_comparison_check, :weight_comparison_check

    private

    def price_criteria_check
      if price_from.present? && price_to.present? && criteria == "weight" && !weight_from.present? && !weight_to.present?
        errors.add(:base, "Criteria is not correct")
      else
        return
      end
    end

    def weight_criteria_check
      if weight_from.present? && weight_to.present? && criteria == "price" && !price_from.present? && !price_to.present?
        errors.add(:base, "Criteria is not correct")
      else
        return
      end
    end

    def price_comparison_check
      if price_to.present? && price_from.present? && price_to < price_from
        errors.add(:base, "price_to must be greater than price_from")
      else
        return
      end
    end

    def weight_comparison_check
      if weight_from.present? && weight_to.present? && weight_to < weight_from
        errors.add(:base, "weight_to must be greater than weight_from")
      else
        return
      end
    end

  end
end
