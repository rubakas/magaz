class MagazCore::AdminServices::LinkList::DeleteLinkList < ActiveInteraction::Base

  integer :shop_id
  string :id

  validates :id, :shop_id, presence: true

  def execute
    MagazCore::Shop.find(shop_id).link_lists.friendly.find(id).destroy
  end
end
