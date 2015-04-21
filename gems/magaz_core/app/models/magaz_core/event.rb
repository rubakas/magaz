module MagazCore
  class Event < ActiveRecord::Base
    self.table_name = 'events'
    belongs_to :shop

    belongs_to :subject, polymorphic: true
  end
end