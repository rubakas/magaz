require 'json'

ActiveSupport::Notifications.subscribe 'events' do |name, data|
  # puts "*******************************"
  # Rails.logger.debug(["notification:", shop_id, subject_id].join(" "))
  # puts "*******************************"
  shop = MagazCore::Shop.find(data[:event][:shop_id])
  webhook = shop.webhooks.find_by(topic: "Product creation")
  unless webhook == nil
    if webhook.format == "XML"
      some = data.to_xml
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      puts some
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    else
      some = data.to_json
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      puts some
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    end
  else
    puts "*****************************************************"
  end
end