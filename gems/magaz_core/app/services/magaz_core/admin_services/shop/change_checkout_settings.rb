class MagazCore::AdminServices::Shop::ChangeCheckoutSettings < ActiveInteraction::Base

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

  validate :account_type_choice_included?
  validate :abandoned_checkout_time_delay_included?
  validate :email_marketing_choice_included?
  validate :after_order_paid_included?

  def execute
    shop = MagazCore::Shop.find(id)
    shop.update_attributes!(inputs.slice!(:ids)) ||
      errors.add(:base, I18n.t('default.services.not_unique',
                               model: I18n.t('default.services.shop')))

    shop
  end

  private

  def account_type_choice_included?
    ACCOUNT_TYPE_CHOISE.include?(account_type_choice)
  end

  def abandoned_checkout_time_delay_included?
    ABANDONED_CHECKOUT_TIME_DELAY.include?(abandoned_checkout_time_delay)
  end

  def email_marketing_choice_included?
    EMAIL_MARKETING_CHOICE.include?(email_marketing_choice)
  end

  def after_order_paid_included?
    AFTER_ORDER_PAID.include?(after_order_paid)
  end

end
