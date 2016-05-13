module MagazCore
  class TaxOverride < ActiveRecord::Base
    self.table_name = 'tax_overrides'

    belongs_to :collection
    belongs_to :shipping_country
  end
end
