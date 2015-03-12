module MagazCore
  class TaxOverride < ActiveRecord::Base
    self.table_name = 'tax_overrides'

    belongs_to :collection
    belongs_to :shipping_country

    before_create :if_shipping

    validates_presence_of :rate, :shipping_country_id
    validates_numericality_of :rate

    validate :check_method

    private

    def if_shipping
      if is_shipping == true
        collection_id == nil
      end
    end

    def check_method
      if is_shipping == false && collection_id == nil
        errors.add(:collection_id, "Collection is not selected")
      end
    end
  end
end
