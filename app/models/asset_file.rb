class AssetFile < ActiveRecord::Base
  self.table_name = 'files'

  belongs_to :shop

  mount_uploader :file, FileUploader
  validates :name, :shop_id, :file, presence: true
end
