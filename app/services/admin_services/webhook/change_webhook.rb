class AdminServices::Webhook::ChangeWebhook

  attr_reader :success, :webhook, :errors
  alias_method :success?, :success

  def initialize  shop_id: nil,
                  webhook_id:,
                  webhook_params: {
                    'topic'   => nil,
                    'format'  => nil,
                    'fields'  => nil,
                    'address' => nil,
                    'metafield_namespaces' => nil
                  }

    @webhook = ::Shop
                .find(shop_id)
                .webhooks
                .find(webhook_id)

    @webhook_params = webhook_params
  end

  def run
    @webhook.assign_attributes(@webhook_params)
    if @webhook.valid?
      @success = true
      @webhook.save
    else
      @success = false
      @errors = @webhook.errors
    end
    self
  end
end
