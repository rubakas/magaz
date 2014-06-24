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
    
    belongs_to :product
    belongs_to :shop

    mount_uploader :image, MagazCore::ImageUploader
  end
end
