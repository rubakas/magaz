module MagazCore
  class Taxe < ActiveRecord::Base
    self.table_name = 'taxes'

    belongs_to :shipping_countries
  end
end