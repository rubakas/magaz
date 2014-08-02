module MagazCore
  class Link < ActiveRecord::Base
    self.table_name = 'links'

    #TODO, dependent: :destroy?
    belongs_to :link_list

  end
end