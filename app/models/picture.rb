# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#

class Picture < ActiveRecord::Base
  belongs_to :shop
  belongs_to :product

  mount_uploader :image, ImageUploader
end
