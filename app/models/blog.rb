# == Schema Information
#
# Table name: blogs
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  shop_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string(255)
#  page_title       :string(255)
#  meta_description :string(255)
#

class Blog < ActiveRecord::Base
  extend FriendlyId

  belongs_to :shop
  has_many :articles
  has_many :comments

  friendly_id :handle, use: :slugged

  validates :title,
    presence: true,
    uniqueness: { scope: :shop_id }
  validates :handle, uniqueness: { scope: :shop_id }
end
