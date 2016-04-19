class MagazCore::AdminServices::File::DeleteFile < ActiveInteraction::Base

  integer :id, :shop_id

  def execute
    MagazCore::Shop.find_by_id(shop_id).files.find(id).destroy
  end
end