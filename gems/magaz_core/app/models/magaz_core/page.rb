# == Schema Information
#
# Table name: pages
#
#  id               :integer          not null, primary key
#  title            :string
#  content          :string
#  shop_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string
#  page_title       :string
#  meta_description :string
#  slug             :string
#  publish_on       :datetime
#  published_at     :datetime
#

module MagazCore
  class Page < ActiveRecord::Base
    self.table_name = 'pages'
    extend FriendlyId
    include Concerns::Visibility
    
    belongs_to :shop

    friendly_id :handle, use: [:slugged, :scoped], scope: :shop

    validates :title,
      presence: true,
      uniqueness: { scope: :shop_id }

    def should_generate_new_friendly_id?
      handle_changed?
    end
  end
end
