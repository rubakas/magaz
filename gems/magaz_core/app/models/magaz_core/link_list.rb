module MagazCore
  class LinkList < ActiveRecord::Base
    self.table_name = 'link_lists'

    belongs_to :shop
    has_many   :links

    accepts_nested_attributes_for :links

    validates :name,
      presence: true,
      uniqueness: { scope: :shop_id }
  end
end