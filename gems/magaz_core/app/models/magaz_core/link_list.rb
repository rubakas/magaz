# == Schema Information
#
# Table name: link_lists
#
#  id      :integer          not null, primary key
#  name    :string
#  shop_id :integer
#  handle  :string
#  slug    :string
#

module MagazCore
  class LinkList < ActiveRecord::Base
    extend FriendlyId
    self.table_name = 'link_lists'

    belongs_to :shop
    has_many   :links

    accepts_nested_attributes_for :links
    friendly_id :handle, use: [:slugged, :scoped], scope: :shop
  end
end
