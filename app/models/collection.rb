# == Schema Information
#
# Table name: collections
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :text
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

class Collection < ActiveRecord::Base
  extend FriendlyId
  include Concerns::Visibility

  has_many                :events, as: :subject
  has_and_belongs_to_many :products
  belongs_to              :shop
  has_many                :tax_overrides

  friendly_id :handle, use: [:slugged, :scoped], scope: [:shop]

  validates :name, :shop_id, presence: true
  validates :name, uniqueness: { scope: :shop }
end
