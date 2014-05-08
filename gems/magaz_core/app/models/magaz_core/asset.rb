module MagazCore
  class Asset < ActiveRecord::Base
    self.table_name = 'assets'
    belongs_to :theme
  end
end