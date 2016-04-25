class MagazCore::AdminServices::File::DeleteFile < ActiveInteraction::Base

  integer :id, :shop_id
  validates :id, :shop_id, presence: true 
  
  def execute
    MagazCore::Shop.find(shop_id).files.find(id).destroy
  end
end