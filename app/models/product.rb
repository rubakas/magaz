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
  has_many                :product_images, :dependent => :destroy
  belongs_to              :shop

  friendly_id :handle, use: [:slugged, :scoped], scope: :shop

  def should_generate_new_friendly_id?
    slug.blank? || handle_changed?
  end

  accepts_nested_attributes_for :product_images, :allow_destroy => true

  validates :name, :shop_id, presence: true
  validates :name, uniqueness: { scope: :shop_id }
  validates :price, numericality: true, allow_blank: true
end
