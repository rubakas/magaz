module MagazCore
  class ShippingRate < ActiveRecord::Base
    self.table_name = 'shipping_rates'

    belongs_to :country

    validates_presence_of :name, :shipping_price

    validate :price_criteria_check
    validate :weight_criteria_check

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

  end
end
