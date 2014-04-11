# == Schema Information
#
# Table name: pages
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  content          :string(255)
#  shop_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  handle           :string(255)
#  page_title       :string(255)
#  meta_description :string(255)
#

class Page < ActiveRecord::Base
  extend FriendlyId
  belongs_to :shop

  friendly_id :handle, use: :slugged

  validates :title,
    presence: true,
    uniqueness: { scope: :shop_id }
  validates :handle, uniqueness: { scope: :shop_id }

  def should_generate_new_friendly_id?
    handle_changed?
  end
end
