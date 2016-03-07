# == Schema Information
#
# Table name: articles
#
#  id               :integer          not null, primary key
#  title            :string
#  content          :text
#  blog_id          :integer
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
  class Article < ActiveRecord::Base
    self.table_name = 'articles'
    extend FriendlyId
    include Concerns::Visibility

    belongs_to :blog
    has_many :comments
    has_many :events, as: :subject

    friendly_id :handle, use: [:slugged, :scoped], scope: :blog

    # validates :title,
    #   presence: true,
    #   uniqueness: { scope: :blog_id }

    def should_generate_new_friendly_id?
      handle_changed?
    end
  end
end
