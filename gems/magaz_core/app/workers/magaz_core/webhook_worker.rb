require 'sidekiq'
require 'json'
require 'net/http'
require 'net/https'
require 'uri'

module MagazCore
  class WebhookWorker
    include Sidekiq::Worker

    def perform(format, address, mail)
      puts "!!!!!!!!!!!"
      uri = URI.parse("#{address}")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, initheader = {"Content-Type" =>"application/#{format}"})
      req.body = "[ #{mail} ]"
      puts "************************"
      puts uri.path
      puts uri.path.inspect
      res = https.request(req)
      puts "Response #{res.code} #{res.message}: #{res.body}"
      if res.code != 200
        self.perform(format, address, mail)
      end
    end
  end
end