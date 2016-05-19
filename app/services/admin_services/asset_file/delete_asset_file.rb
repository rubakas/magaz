class AdminServices::AssetFile::DeleteAssetFile < ActiveInteraction::Base

  integer :id, :shop_id
  validates :id, :shop_id, presence: true

  def execute
    Shop.find(shop_id).asset_files.find(id).destroy
  end
end
