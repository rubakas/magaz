class MagazCore::ShopServices::Link::DeleteLink < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    MagazCore::Link.find(id).destroy
  end
end
