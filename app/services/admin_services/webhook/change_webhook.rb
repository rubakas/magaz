class AdminServices::Webhook::ChangeWebhook < ActiveInteraction::Base

  set_callback :validate, :after, -> {webhook}

  integer :shop_id, :id
  string :topic, :address, :format
  array :metafield_namespaces, :fields, default: nil

  validates :topic, inclusion: Webhook::Topics::WEBHOOKS_TOPICS_LIST
  validates :format, inclusion: Webhook::FORMAT_CHOICE
  validates :address, presence: true,
                      format: { with: /https?:\/\/[\S]+/ }
  def webhook
    @webhook = Shop.find(shop_id).webhooks.find(id)
    add_errors if errors.any?
    @webhook
  end

  def execute
    @webhook.update_attributes(inputs.slice!(:id, :shop_id)) ||
      errors.add(:base, I18n.t('services.change_webhook.wrong_params'))
    @webhook
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @webhook.errors.add(:base, msg)
    end
  end

end
