module MagazCore
  class TaxOverride < ActiveRecord::Base
    self.table_name = 'tax_overrides'

    belongs_to :collection
    belongs_to :shipping_country

    before_create :if_shipping

    validates_presence_of :rate, :shipping_country_id
    validates_numericality_of :rate

    validate :check_method
    validate :check_uniqueness

    private

    def if_shipping
      if is_shipping == true
        collection_id == nil
      end
    end

    def check_uniqueness
      @shipping_country = MagazCore::ShippingCountry.find_by_id(self.shipping_country_id)
      @shop = MagazCore::Shop.find_by_id(@shipping_country.shop_id)
      @collection = @shop.collections.find_by_id(self.collection_id)
      if self.is_shipping == false
        @override = @shipping_country.tax_overrides.find_by(collection_id: @collection.id)
      else
        @override = @shipping_country.tax_overrides.find_by(is_shipping: true)
      end
      unless @override == nil
        errors.add(:collection_id, "Collection already exists")
      else
        return
      end
    end

    def check_method
      if is_shipping == false && collection_id == nil
        errors.add(:collection_id, "Collection is not selected")
      else
        return
      end
    end
  end
end
