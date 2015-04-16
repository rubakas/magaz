module MagazCore
  class Event < ActiveRecord::Base
    self.table_name = 'events'
    belongs_to :shop
  end
end