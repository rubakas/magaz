class MagazCore::AdminServices::Webhook::AddWebhook < ActiveInteraction::Base

  FORMAT_CHOICE = ["JSON", "XML"]

  integer :shop_id
  string :topic, :address, :format
  array :metafield_namespaces, :fields, default: nil

  validates :topic, inclusion: MagazCore::Webhook::Topics::WEBHOOKS_TOPICS_LIST
  validates :format, inclusion: FORMAT_CHOICE
  validates :address, presence: true,
                      format: { with: /https?:\/\/[\S]+/ }

  def execute
    webhook = MagazCore::Shop.find(shop_id).webhooks.new(inputs)

    unless webhook.save
      errors.merge!(webhook.errors)
    end

    webhook
  end

end
