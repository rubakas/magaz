# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  shop_id     :integer
#  price       :decimal(38, 2)
#

class Product < ActiveRecord::Base
  has_and_belongs_to_many :collections
  has_many :product_images
  belongs_to :shop

  accepts_nested_attributes_for :product_images

  validates :name, presence: true, uniqueness: { scope: :shop_id }
end
