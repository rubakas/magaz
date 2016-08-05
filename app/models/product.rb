# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#  shop_id          :integer
#  price            :decimal(38, 2)
#  handle           :string
#  page_title       :string
#  meta_description :string
#  slug             :string
#  publish_on       :datetime
#  published_at     :datetime
#

class Product < ActiveRecord::Base
  extend FriendlyId
  include Concerns::Visibility

  has_and_belongs_to_many :collections
  has_many                :events, as: :subject
  has_many                :product_images, :dependent => :destroy
  belongs_to              :shop

  friendly_id :handle, use: [:slugged, :scoped], scope: :shop

  accepts_nested_attributes_for :product_images, :allow_destroy => true

  validates :name, :shop_id, presence: true
  validates :name, uniqueness: { scope: :shop }
  validates :price, number: true, allow_blank: true
end
