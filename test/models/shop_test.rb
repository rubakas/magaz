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

require 'test_helper'

class ShopTest < ActiveSupport::TestCase
  should have_many :articles
  should have_many :asset_files
  should have_many :blogs
  should have_many :checkouts
  should have_many :collections
  should have_many :comments
  should have_many :countries
  should have_many :customers
  should have_many :email_templates
  should have_many :links
  should have_many :link_lists
  should have_many :pages
  should have_many :product_images
  should have_many :products
  should have_many :shipping_countries
  should have_many :shipping_rates
  should have_many :subscriber_notifications
  should have_many :themes
  should have_many :users
  should belong_to :eu_digital_goods_collection
  should have_many :webhooks
  should validate_presence_of(:name)
  should validate_presence_of(:subdomain)
end
