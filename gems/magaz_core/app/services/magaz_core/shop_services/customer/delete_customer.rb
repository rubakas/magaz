class MagazCore::ShopServices::Customer::DeleteCustomer < ActiveInteraction::Base

  integer :id

  validates :id, presence: true

  def execute
    MagazCore::Customer.find(id).destroy
  end
end
