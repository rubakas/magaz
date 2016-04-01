class MagazCore::AdminServices::Page::DeletePage < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    MagazCore::Page.friendly.find(id).destroy
  end
end
