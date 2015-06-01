module MagazCore
  module ShopServices
    class EventWebhookRunner
      include MagazCore::Concerns::Service

      def call(event:, webhook:)
        @shop = event.shop

        @shop.webhooks.where(topic: webhook).each do |w|
          unless w == nil
            case w.format
            when "XML"
              mail = event.to_xml
            when "JSON"
              mail = event.to_json
            end
            format = w.format.downcase
            address = w.address
            MagazCore::WebhookWorker.perform_async(mail, address, format)
          end
        end
      end
    end
  end
end