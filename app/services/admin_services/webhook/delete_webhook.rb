class AdminServices::Webhook::DeleteWebhook < ActiveInteraction::Base

  integer :id, :shop_id

  validates :id, :shop_id, presence: true

  def execute
    Shop.find(shop_id).webhooks.find(id).destroy
  end

end
