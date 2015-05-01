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
    include Concerns::SubdomainOwner
    has_many :articles, through: :blogs
    has_many :blogs
    has_many :collections
    has_many :comments, through: :articles
    has_many :checkouts, through: :customers
    has_many :countries
    has_many :customers
    has_many :files
    has_many :links, through: :link_lists
    has_many :link_lists
    has_many :pages
    has_many :product_images
    has_many :products
    has_many :shipping_countries
    has_many :shipping_rates, through: :shipping_countries
    has_many :themes
    has_many :users, class_name: 'MagazCore::User', :dependent => :destroy
    has_many :subscriber_notifications
    has_many :email_templates, class_name: 'MagazCore::EmailTemplate', :dependent => :destroy
    belongs_to :eu_digital_goods_collection, class_name: 'MagazCore::Collection' , foreign_key: "eu_digital_goods_collection_id"
    has_many :events
    has_many :webhooks

    ABANDONED_CHECKOUT_TIME_DELAY = [I18n.t('activerecord.models.shop.never'), I18n.t('activerecord.models.shop.six_hours'), I18n.t('activerecord.models.shop.day')]
    EMAIL_MARKETING_CHOICE = [I18n.t('activerecord.models.shop.customer_agrees'), I18n.t('activerecord.models.shop.customer_does_not_agree'), I18n.t('activerecord.models.shop.disable')]

    validates :name, presence: true, uniqueness: true
    validates :abandoned_checkout_time_delay, inclusion: ABANDONED_CHECKOUT_TIME_DELAY, :allow_blank => true
    validates :email_marketing_choice, inclusion: EMAIL_MARKETING_CHOICE, :allow_blank => true
  end
end
