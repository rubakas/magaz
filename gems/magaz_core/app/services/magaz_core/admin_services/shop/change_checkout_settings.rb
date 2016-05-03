class MagazCore::AdminServices::Shop::ChangeCheckoutSettings < ActiveInteraction::Base

  set_callback :validate, :after, -> {shop}

  ACCOUNT_TYPE_CHOISE = %w[ disabled required optional]

  AFTER_ORDER_PAID = %w[ automatically_fulfill
                         automatically_fulfill_gift_cards
                         not_automatically_fulfill]

  ABANDONED_CHECKOUT_TIME_DELAY = %w[ never six_hours day]

  EMAIL_MARKETING_CHOICE = %w[ customer_agrees customer_does_not_agree disable ]

  boolean :billing_address_is_shipping_too, :enable_multipass_login,
          :notify_customers_of_their_shipment, :automatically_fulfill_all_orders,
          :after_order_fulfilled_and_paid, default: false

  string :account_type_choice,
         default: ACCOUNT_TYPE_CHOISE[ACCOUNT_TYPE_CHOISE.index('disabled')]
  string :abandoned_checkout_time_delay,
         default: ABANDONED_CHECKOUT_TIME_DELAY[ABANDONED_CHECKOUT_TIME_DELAY.index('never')]
  string :email_marketing_choice,
         default: EMAIL_MARKETING_CHOICE[EMAIL_MARKETING_CHOICE.index('customer_agrees')]
  string :after_order_paid,
         default: AFTER_ORDER_PAID[AFTER_ORDER_PAID.index('automatically_fulfill')]
  string :checkout_refund_policy, :checkout_privacy_policy, :checkout_term_of_service,
         default: nil

  integer :id

  validates :id, presence: true

  validates :account_type_choice, inclusion: ACCOUNT_TYPE_CHOISE
  validates :abandoned_checkout_time_delay, inclusion: ABANDONED_CHECKOUT_TIME_DELAY
  validates :email_marketing_choice, inclusion: EMAIL_MARKETING_CHOICE
  validates :after_order_paid, inclusion: AFTER_ORDER_PAID

  def shop
    @shop = MagazCore::Shop.find(id)
    add_errors if errors.any?
    @shop
  end

  def execute
    @shop.update_attributes!(inputs.slice!(:id)) ||
      errors.add(:base, I18n.t('services.shop_services.wrong_params'))

    @shop
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @shop.errors.add(:base, msg)
    end
  end

end
