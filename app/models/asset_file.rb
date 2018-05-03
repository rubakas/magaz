# == Schema Information
#
# Table name: files
#
#  id         :integer          not null, primary key
#  file       :string
#  name       :string
#  shop_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  file_size  :integer
#

class AssetFile < ActiveRecord::Base
  self.table_name = 'files'

  belongs_to :shop

  mount_uploader :file, FileUploader
  validates :name, :shop_id, :file, presence: true
end
