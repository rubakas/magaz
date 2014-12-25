# == Schema Information
#
# Table name: shops
#
#  id               :integer          not null, primary key
#  email            :string
#  name             :string
#  password_digest  :string
#  created_at       :datetime
#  updated_at       :datetime
#  password_salt    :string
#  subdomain        :string
#  address          :string
#  business_name    :string
#  city             :string
#  country          :string
#  currency         :string
#  customer_email   :string
#  phone            :string
#  province         :string
#  timezone         :string
#  unit_system      :string
#  zip              :integer
#  handle           :string
#  page_title       :string
#  meta_description :string
#

module MagazCore
  class Shop < ActiveRecord::Base
    self.table_name = 'shops'
    include Concerns::PasswordAuthenticable
    include Concerns::SubdomainOwner
    has_many :articles, through: :blogs
    has_many :blogs
    has_many :collections
    has_many :comments, through: :articles
    has_many :checkouts, through: :customers
    has_many :customers
    has_many :files
    has_many :links, through: :link_lists
    has_many :link_lists
    has_many :pages
    has_many :product_images
    has_many :products
    has_many :themes
    has_many :users

    ACCOUNT_TYPE_CHOICE = ["Account are disabled","Account are required","Account are optional"]
    ABANDONED_CHECKOUT_TIME_DELAY = ["Never","Six hours later","24 hours later"]
    EMAIL_MARKETING_CHOICE = ["Customer agrees to receive promotional emails by default.","Customer does not agree to receive promotional emails by default.","Disable and hide this field."]
    AFTER_ORDER_PAID = ["Automatically fulfill the orders line items.","Automatically fulfill only the gift cards of the order.","Do not automatically fulfill any of the orders line items."]
    #CHECHOUT_LANGUAGE = ["English"]

    AUTHORIZ_SETTINGS = ['Authorize and charge the customers credit card.', 'Authorize the customers credit card.']
    validates :authoriz_settings, inclusion: AUTHORIZ_SETTINGS, :allow_blank => true

    validates :account_type_choice, inclusion: ACCOUNT_TYPE_CHOICE, :allow_blank => true
    validates :abandoned_checkout_time_delay, inclusion: ABANDONED_CHECKOUT_TIME_DELAY,:allow_blank => true
    validates :email_marketing_choice, inclusion: EMAIL_MARKETING_CHOICE,:allow_blank => true
    validates :after_order_paid, inclusion: AFTER_ORDER_PAID,:allow_blank => true
  end
end
