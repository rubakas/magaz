class AdminServices::Checkout::DeleteCheckout < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    Checkout.find(id).destroy
  end

end
