require 'json'
require 'net/http'
require 'net/https'
require 'uri'


ActiveSupport::Notifications.subscribe 'create product event' do |name, data|
  shop = MagazCore::Shop.find(data[:event][:shop_id])
  shop.webhooks.where(topic: "Product creation").each do |webhook|
    run_worker(data: data, webhook: webhook)
  end
end

def run_worker(data: {}, webhook:)
  unless webhook == nil
    if webhook.format == "XML"
      mail = data.to_xml
    else
      mail = data.to_json
    end
    format = webhook.format.downcase
    address = webhook.address
    MagazCore::WebhookWorker.perform_async(format, address, mail)
  end
end