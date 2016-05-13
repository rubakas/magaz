class AdminServices::Customer::DeleteCustomer < ActiveInteraction::Base

  integer :id, :shop_id

  validates :id, :shop_id, presence: true

  def execute
    Shop.find(shop_id).customers.find(id).destroy
  end
end
