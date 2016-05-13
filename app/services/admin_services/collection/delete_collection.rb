class AdminServices::Collection::DeleteCollection < ActiveInteraction::Base

  integer :shop_id
  string :id

  validates :id, :shop_id, presence: true

  def execute
    Shop.find(shop_id).collections.friendly.find(id).destroy
  end
end
