# == Schema Information
#
# Table name: shops
#
#  id                                 :integer          not null, primary key
#  name                               :string
#  created_at                         :datetime
#  updated_at                         :datetime
#  password_salt                      :string
#  subdomain                          :string
#  address                            :string
#  business_name                      :string
#  city                               :string
#  country                            :string
#  currency                           :string
#  customer_email                     :string
#  phone                              :string
#  province                           :string
#  timezone                           :string
#  unit_system                        :string
#  zip                                :integer
#  handle                             :string
#  page_title                         :string
#  meta_description                   :string
#  account_type_choice                :string
#  billing_address_is_shipping_too    :boolean
#  abandoned_checkout_time_delay      :string
#  email_marketing_choice             :string
#  after_order_paid                   :string
#  after_order_fulfilled_and_paid     :boolean
#  checkout_language                  :string
#  checkout_refund_policy             :text
#  checkout_privacy_policy            :text
#  checkout_term_of_service           :text
#  enable_multipass_login             :boolean
#  notify_customers_of_their_shipment :boolean
#  automatically_fulfill_all_orders   :boolean
#  authorization_settings             :string
#  all_taxes_are_included             :boolean
#  charge_taxes_on_shipping_rates     :boolean
#  eu_digital_goods_collection_id     :integer
#

class Shop < ActiveRecord::Base
  include Concerns::SubdomainOwner

  ACCOUNT_TYPE_CHOISE = %w[ disabled required optional]

  AFTER_ORDER_PAID = %w[ automatically_fulfill
                         automatically_fulfill_gift_cards
                         not_automatically_fulfill]

  ABANDONED_CHECKOUT_TIME_DELAY = %w[ never six_hours day]

  EMAIL_MARKETING_CHOICE = %w[ customer_agrees customer_does_not_agree disable ]

  has_many :blogs
  has_many :articles, through: :blogs
  has_many :asset_files
  has_many :customers
  has_many :checkouts, through: :customers
  has_many :collections
  has_many :comments, through: :articles
  has_many :countries, class_name: 'ShippingCountry'
  has_many :email_templates, :dependent => :destroy
  has_many :link_lists
  has_many :links, through: :link_lists
  has_many :pages
  has_many :products
  has_many :product_images, through: :products
  has_many :shipping_countries
  has_many :shipping_rates, through: :shipping_countries
  has_many :subscriber_notifications
  has_many :themes
  has_many :users, dependent: :destroy
  belongs_to :eu_digital_goods_collection, class_name: 'Collection' , foreign_key: "eu_digital_goods_collection_id"
  has_many :webhooks

  validates :name, presence: true
  validates :name, uniqueness: true

  validates :all_taxes_are_included, :charge_taxes_on_shipping_rates, inclusion: { in: [true, false] }

  validates :authorization_settings, inclusion: { in: %w[ authorize_and_charge authorize ] }, allow_blank: true
  validates :eu_digital_goods_collection_id, numericality: { only_integer: true }, allow_blank: true
  validate :validate_default_collection_id

  validates :account_type_choice, inclusion: ACCOUNT_TYPE_CHOISE, allow_nil: true
  validates :abandoned_checkout_time_delay, inclusion: ABANDONED_CHECKOUT_TIME_DELAY, allow_nil: true
  validates :email_marketing_choice, inclusion: EMAIL_MARKETING_CHOICE, allow_nil: true
  validates :after_order_paid, inclusion: AFTER_ORDER_PAID, allow_nil: true

  validates :country, inclusion: YAML.load_file("#{Rails.root}/config/countries.yml")['countries'].keys, allow_nil: true
  validates :unit_system, inclusion: %w[ metric imperial], allow_nil: true
  validates :currency, inclusion: %w[ USD EURO HRN], allow_nil: true
  #TODO .zones_map method is private now
  validates :timezone, inclusion: ActiveSupport::TimeZone.send(:zones_map).values.collect{|z| z.name}, allow_nil: true
  validates :customer_email, format: { with: Concerns::PasswordAuthenticable::EMAIL_VALID_REGEX }, allow_nil: true

  def validate_default_collection_id
    if self.eu_digital_goods_collection_id != nil
      collection = Collection.where(shop_id: self.id, id: self.eu_digital_goods_collection_id)
      errors.add(:base, I18n.t('services.shop_services.wrong_collection')) unless collection.present?
    end
  end
end
