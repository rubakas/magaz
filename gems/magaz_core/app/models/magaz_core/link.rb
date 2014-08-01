module MagazCore
  class Link < ActiveRecord::Base
    self.table_name = 'links'

    belongs_to :linklist

  end
end