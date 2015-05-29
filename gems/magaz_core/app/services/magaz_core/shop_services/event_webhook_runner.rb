module MagazCore
  module ShopServices
    class EventWebhookRunner
      include MagazCore::Concerns::Service

      def call(event:, webhook:)
        @shop = event.shop

        MagazCore::Shop.connection.transaction do
          begin
            _check_webhook(shop: @shop, webhook: webhook, data: event.attributes)
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def _check_webhook(shop:, webhook:, data:)
        unless webhook == 'nil' && shop.webhooks.where(topic: webhook).count == 0
          shop.webhooks.where(topic: webhook).each do |webhook|
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
          MagazCore::WebhookWorker.perform_async(format, address, mail) || fail(ArgumentError)
        end
      end
    end
  end
end