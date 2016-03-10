# == Schema Information
#
# Table name: blogs
#
#  id               :integer          not null, primary key
#  title            :string
#  shop_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string
#  page_title       :string
#  meta_description :string
#  slug             :string
#

module MagazCore
  class Blog < ActiveRecord::Base
    self.table_name = 'blogs'
    extend FriendlyId

    has_many :articles
    has_many :comments
    has_many :events, as: :subject
    belongs_to :shop

    friendly_id :handle, use: [:slugged, :scoped], scope: :shop

    def should_generate_new_friendly_id?
      handle_changed?
    end
  end
end
