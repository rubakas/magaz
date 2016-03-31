class MagazCore::ShopServices::Webhook::EventWebhookRunner
  include MagazCore::Concerns::Service

  def call(event:, topic:)
    @shop = event.shop

    @shop.webhooks.where(topic: topic).each do |w|
      MagazCore::WebhookWorker.perform_async(w.id, event.id)
    end
  end
end
