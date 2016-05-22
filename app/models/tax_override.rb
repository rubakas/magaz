class TaxOverride < ActiveRecord::Base
  belongs_to :collection
  belongs_to :shipping_country
end
