require 'sidekiq'
require 'net/http'
require 'net/https'
require 'uri'

module MagazCore
  class WebhookWorker
    include Sidekiq::Worker

    def perform(mail, address, format)
      uri = URI.parse("#{address}")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, initheader = {"Content-Type" =>"application/#{format}"})
      req.body = "[ #{mail} ]"
      res = https.request(req)
      puts "Response #{res.code} #{res.message}: #{res.body}"
    end
  end
end