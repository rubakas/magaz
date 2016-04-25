class MagazCore::AdminServices::Page::DeletePage < ActiveInteraction::Base

  string :id
  integer :shop_id
  validates :id, :shop_id, presence: true

  def execute
    MagazCore::Shop.find(shop_id).pages.friendly.find(id).destroy
  end
end
