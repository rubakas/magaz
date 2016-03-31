class MagazCore::ShopServices::LinkList::DeleteLinkList < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    MagazCore::LinkList.friendly.find(id).destroy
  end
end
