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
    has_many :blogs, class_name: 'MagazCore::Blog', :dependent => :destroy
    has_many :collections, class_name: 'MagazCore::Collection', :dependent => :destroy
    has_many :comments, through: :articles
    has_many :checkouts, through: :customers
    has_many :customers
    has_many :files, class_name: 'MagazCore::File', :dependent => :destroy
    has_many :links, through: :link_lists
    has_many :link_lists, class_name: 'MagazCore::LinkList', :dependent => :destroy
    has_many :pages, class_name: 'MagazCore::Page', :dependent => :destroy
    has_many :products, class_name: 'MagazCore::Product', :dependent => :destroy
    has_many :shipping_countries, class_name: 'MagazCore::ShippingCountry', :dependent => :destroy
    has_many :shipping_rates, through: :shipping_countries
    has_many :themes, class_name: 'MagazCore::Theme', :dependent => :destroy
    has_many :users, class_name: 'MagazCore::User', :dependent => :destroy
    has_many :subscriber_notifications, class_name: 'MagazCore::SubscriberNotification', :dependent => :destroy
    has_many :email_templates, class_name: 'MagazCore::EmailTemplate', :dependent => :destroy
    belongs_to :eu_digital_goods_collection, class_name: 'MagazCore::Collection' , foreign_key: "eu_digital_goods_collection_id"
    has_many :events, class_name: 'MagazCore::Event', :dependent => :destroy
    has_many :webhooks, class_name: 'MagazCore::Webhook', :dependent => :destroy

    ABANDONED_CHECKOUT_TIME_DELAY = %w[ never six_hours day]
    EMAIL_MARKETING_CHOICE = %w[ customer_agrees customer_does_not_agree disable ]

    validates :name, presence: true, uniqueness: true
    validates :abandoned_checkout_time_delay, inclusion: ABANDONED_CHECKOUT_TIME_DELAY, :allow_blank => true
    validates :email_marketing_choice, inclusion: EMAIL_MARKETING_CHOICE, :allow_blank => true
  end
end
