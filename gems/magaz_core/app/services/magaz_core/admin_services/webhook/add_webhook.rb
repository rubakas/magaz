class MagazCore::AdminServices::Webhook::AddWebhook < ActiveInteraction::Base

  set_callback :validate, :after, -> {webhook}

  integer :shop_id
  string :topic, :address, :format
  array :metafield_namespaces, :fields, default: nil

  validates :topic, inclusion: MagazCore::Webhook::Topics::WEBHOOKS_TOPICS_LIST
  validates :format, inclusion: MagazCore::Webhook::FORMAT_CHOICE
  validates :address, presence: true,
                      format: { with: /https?:\/\/[\S]+/ }

  def webhook
    @webhook = MagazCore::Webhook.new
    add_errors if errors.any?
    @webhook
  end

  def execute
    unless @webhook.update_attributes(inputs)
      errors.merge!(@webhook.errors)
    end
    @webhook
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @webhook.errors.add(:base, msg)
    end
  end

end
