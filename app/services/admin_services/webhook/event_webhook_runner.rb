class AdminServices::Webhook::EventWebhookRunner
  include Concerns::Service

  def call(event:, topic:)
    @shop = event.shop

    @shop.webhooks.where(topic: topic).each do |w|
      WebhookWorker.perform_async(w.id, event.id)
    end
  end
end
