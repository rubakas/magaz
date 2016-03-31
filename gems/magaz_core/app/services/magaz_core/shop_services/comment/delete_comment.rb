class MagazCore::ShopServices::Comment::DeleteComment < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    MagazCore::Comment.find(id).destroy
  end
end
