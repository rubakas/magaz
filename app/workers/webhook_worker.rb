require 'sidekiq'
require 'net/http'
require 'net/https'
require 'uri'


class WebhookWorker
  include Sidekiq::Worker

  def perform(webhook_id, event_id)
    webhook = Webhook.find(webhook_id)
    event = Event.find(event_id)
    unless webhook == nil
      case webhook.format
      when "XML"
        mail = event.to_xml
      when "JSON"
        mail = event.to_json
      end
    end
    format = webhook.format.downcase
    address = webhook.address
    uri = URI.parse("#{address}")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = {"Content-Type" =>"application/#{format}"})
    req.body = "[ #{mail} ]"
    res = https.request(req)
  end
end
