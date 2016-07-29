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

class Article < ActiveRecord::Base
  extend FriendlyId
  include Concerns::Visibility

  belongs_to  :blog
  has_many    :comments
  has_many    :events, as: :subject

  friendly_id :handle, use: [:slugged, :scoped], scope: :blog

  validates :title, :blog_id, presence: true
  validates :title, uniqueness: { scope: :blog_id }
end
