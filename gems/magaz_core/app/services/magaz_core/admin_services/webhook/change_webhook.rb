class MagazCore::AdminServices::Webhook::ChangeWebhook < ActiveInteraction::Base

  FORMAT_CHOICE = ["JSON", "XML"]

  integer :shop_id, :id
  string :topic, :address, :format
  array :metafield_namespaces, :fields, default: nil

  validates :topic, inclusion: MagazCore::Webhook::Topics::WEBHOOKS_TOPICS_LIST
  validates :format, inclusion: FORMAT_CHOICE
  validates :address, presence: true,
                      format: { with: /https?:\/\/[\S]+/ }

  def execute
    webhook = MagazCore::Shop.find(shop_id).webhooks.find(id)
    webhook.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.change_webhook.wrong_params'))

    webhook
  end

end
