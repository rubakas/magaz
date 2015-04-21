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

    DEFAULT_ABOUT_US_TITLE = 'About Us'
    DEFAULT_ABOUT_US_CONTENT = 'The About Us page of your shop is vital because it’s where users go when first trying to determine a level of trust.'

    DEFAULT_WELCOME_TITLE = 'Welcome'
    DEFAULT_WELCOME_CONTENT = 'You made it! Congratulations on starting your own online store!'

    belongs_to :shop
    has_many :events, as: :subject

    friendly_id :handle, use: [:slugged, :scoped], scope: :shop

    validates :title,
      presence: true,
      uniqueness: { scope: :shop_id }

    def should_generate_new_friendly_id?
      handle_changed?
    end
  end
end
