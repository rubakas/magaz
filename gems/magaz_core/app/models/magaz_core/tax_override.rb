module MagazCore
  class TaxOverride < ActiveRecord::Base
    self.table_name = 'tax_overrides'

    has_one :collection
    belongs_to :shipping_country

  end
end
