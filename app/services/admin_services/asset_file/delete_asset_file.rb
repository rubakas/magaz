class AdminServices::AssetFile::DeleteFile < ActiveInteraction::Base

  integer :id, :shop_id
  validates :id, :shop_id, presence: true

  def execute
    Shop.find(shop_id).files.find(id).destroy
  end
end
