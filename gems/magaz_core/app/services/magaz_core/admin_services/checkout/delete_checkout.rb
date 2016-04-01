class MagazCore::AdminServices::Checkout::DeleteCheckout < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    MagazCore::Checkout.find(id).destroy
  end

end
