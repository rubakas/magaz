# == Schema Information
#
# Table name: product_images
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#  product_id :integer
#

class ProductImage < ActiveRecord::Base
  belongs_to :shop
  belongs_to :product

  mount_uploader :image, ImageUploader
end
