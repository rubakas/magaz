class MagazCore::AdminServices::SubscriberNotification::AddSubscriberNotification < ActiveInteraction::Base

  set_callback :validate, :after, -> {subscriber_notification}

  string :notification_method, :subscription_address
  integer :shop_id

  validates :shop_id, :subscription_address, :notification_method, presence: true
  validates :subscription_address, :numericality => {:only_integer => true},
              if: :select_phone_number_method?
  validates :subscription_address, presence: true, length: {maximum: 30 },
              format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i},
                if: :select_email_address_method?
  validate :email_uniqueness, if: :select_email_address_method?

  def subscriber_notification
    @subscriber_notification = MagazCore::SubscriberNotification.new
    add_errors if errors.any?
    @subscriber_notification
  end

  def execute
    unless @subscriber_notification.update_attributes(params)
      errors.merge!(@subscriber_notification.errors)
    end
    @subscriber_notification
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @subscriber_notification.errors.add(:base, msg)
    end
  end

  def params
    params = inputs
    params[:subscription_address] = subscription_address.downcase
    params
  end

  def select_phone_number_method?
    "phone" == notification_method
  end

  def select_email_address_method?
    "email" == notification_method
  end

  def email_uniqueness
    errors.add(:base,
               I18n.t('services.add_subscriber_notification.email_not_unique')) unless email_unique?
  end

  def email_unique?
    MagazCore::SubscriberNotification
      .where(shop_id: shop_id, subscription_address: subscription_address).count == 0
  end

end
