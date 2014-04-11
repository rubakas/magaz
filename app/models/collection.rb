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

class Collection < ActiveRecord::Base
  extend FriendlyId

  has_and_belongs_to_many :products
  belongs_to :shop

  friendly_id :handle, use: :slugged

  validates :name,
    presence: true,
    uniqueness: { scope: :shop_id }
  validates :handle, uniqueness: { scope: :shop_id }
end
