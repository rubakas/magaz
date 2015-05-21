require 'json'
require 'uri'


ActiveSupport::Notifications.subscribe 'event' do |name, data|
  shop = MagazCore::Shop.find(data[:event][:shop_id])
  unless data[:webhook] == 'nil' && shop.webhooks.where(topic: data[:webhook]).count == 0
    shop.webhooks.where(topic: data[:webhook]).each do |webhook|
      run_worker(data: data, webhook: webhook)
    end
  end
end

def run_worker(data: {}, webhook:)
  unless webhook == nil
    case webhook.format
    when "XML"
      mail = data.to_xml
    when "JSON"
      mail = data.to_json
    else
      fail(ArgumentError)
    end
    format = webhook.format.downcase
    address = webhook.address
    MagazCore::WebhookWorker.perform_async(format, address, mail)
  end
end