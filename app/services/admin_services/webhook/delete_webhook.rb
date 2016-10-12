class AdminServices::Webhook::DeleteWebhook

  attr_reader :success, :webhook, :errors
  alias_method :success?, :success

  def execute
    Shop.find(shop_id).webhooks.find(id).destroy
  end

  def initialize(id: nil, shop_id: nil)
    @webhook = Shop.find(shop_id).webhooks.find(id)
  end

  def run
    @success = true
    @webhook.destroy || @success = false
    @errors = @webhook.errors
    self
  end

end
