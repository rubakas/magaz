# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#  shop_id          :integer
#  price            :decimal(38, 2)
#  handle           :string(255)
#  page_title       :string(255)
#  meta_description :string(255)
#

class Product < ActiveRecord::Base
  extend FriendlyId

  has_and_belongs_to_many :collections
  has_many :product_images, :dependent => :destroy
  belongs_to :shop

  friendly_id :handle, use: :slugged

  accepts_nested_attributes_for :product_images, :allow_destroy => true

  validates :name, presence: true, uniqueness: { scope: :shop_id }
  validates :handle, uniqueness: { scope: :shop_id }
end
