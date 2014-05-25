# == Schema Information
#
# Table name: collections
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  shop_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string(255)
#  page_title       :string(255)
#  meta_description :string(255)
#

module MagazCore
  class Collection < ActiveRecord::Base
    self.table_name = 'collections'
    extend FriendlyId

    has_and_belongs_to_many :products, class_name: 'MagazCore::Product'
    belongs_to :shop

    friendly_id :handle, use: [:slugged, :scoped], scope: :shop

    validates :name,
      presence: true,
      uniqueness: { scope: :shop_id }

    def should_generate_new_friendly_id?
      handle_changed?
    end
  end
end