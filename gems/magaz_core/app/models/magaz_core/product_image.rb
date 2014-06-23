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

module MagazCore
  class ProductImage < ActiveRecord::Base
    self.table_name = 'product_images'
    belongs_to :shop
    belongs_to :product

    mount_uploader :image, MagazCore::ImageUploader
  end
end
