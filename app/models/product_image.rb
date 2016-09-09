# == Schema Information
#
# Table name: product_images
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  image      :string
#  product_id :integer
#

class ProductImage < ActiveRecord::Base
  belongs_to :product

  mount_uploader :image, ImageUploader
  validates :product_id, :image, presence: true
end
