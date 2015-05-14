require 'json'
require 'uri'


ActiveSupport::Notifications.subscribe 'create product event' do |name, data|
  shop = MagazCore::Shop.find(data[:event][:shop_id])
  unless shop.webhooks.where(topic: "Product creation").count == 0
    shop.webhooks.where(topic: "Product creation").each do |webhook|
      run_worker(data: data, webhook: webhook)
    end
  end
end

ActiveSupport::Notifications.subscribe 'update product event' do |name, data|
  shop = MagazCore::Shop.find(data[:event][:shop_id])
  unless shop.webhooks.count == 0
    shop.webhooks.where(:topic => "Product update").each do |webhook|
      run_worker(data: data, webhook: webhook)
    end
  end
end

ActiveSupport::Notifications.subscribe 'destroy product event' do |name, data|
  shop = MagazCore::Shop.find(data[:event][:shop_id])
  unless shop.webhooks.count == 0
    shop.webhooks.where(:topic => "Product deletion").each do |webhook|
      run_worker(data: data, webhook: webhook)
    end
  end
end

ActiveSupport::Notifications.subscribe 'create collection event' do |name, data|
  shop = MagazCore::Shop.find(data[:event][:shop_id])
  unless shop.webhooks.count == 0
    shop.webhooks.where(:topic => "Collection create").each do |webhook|
      run_worker(data: data, webhook: webhook)
    end
  end
end

ActiveSupport::Notifications.subscribe 'update collection event' do |name, data|
  shop = MagazCore::Shop.find(data[:event][:shop_id])
  unless shop.webhooks.count == 0
    shop.webhooks.where(:topic => "Collection update").each do |webhook|
      run_worker(data: data, webhook: webhook)
    end
  end
end

ActiveSupport::Notifications.subscribe 'destroy collection event' do |name, data|
  shop = MagazCore::Shop.find(data[:event][:shop_id])
  unless shop.webhooks.count == 0
    shop.webhooks.where(:topic => "Collection deletion").each do |webhook|
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