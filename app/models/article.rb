# == Schema Information
#
# Table name: articles
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  content          :text
#  blog_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string(255)
#  page_title       :string(255)
#  meta_description :string(255)
#

class Article < ActiveRecord::Base
  extend FriendlyId

  belongs_to :blog
  has_many :comments

  friendly_id :handle, use: [:slugged, :scoped], scope: :blog

  validates :title,
    presence: true,
    uniqueness: { scope: :blog_id }

  def should_generate_new_friendly_id?
    handle_changed?
  end
end
