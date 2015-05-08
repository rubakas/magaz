require 'json'
require 'net/http'
require 'net/https'
require 'uri'

ActiveSupport::Notifications.subscribe 'events' do |name, data|
  shop = MagazCore::Shop.find(data[:event][:shop_id])
  webhook = shop.webhooks.find_by(topic: "Product creation")
  unless webhook == nil
    if webhook.format == "XML"
      mail = data.to_xml
      format = 'xml'
    else
      mail = data.to_json
      format = 'json'
    end
    uri = URI.parse("#{webhook.address}")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/#{format}'})
    req.body = "[ #{mail} ]"
    res = https.request(req)
    puts "Response #{res.code} #{res.message}: #{res.body}"
  end
end