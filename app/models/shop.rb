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

class Shop < ActiveRecord::Base
  include Concerns::SubdomainOwner

  has_many :articles, through: :blogs
  has_many :asset_files
  has_many :blogs
  has_many :checkouts, through: :customers
  has_many :collections
  has_many :comments, through: :articles
  has_many :countries, class_name: 'ShippingCountry'
  has_many :customers
  has_many :email_templates, :dependent => :destroy
  has_many :events
  has_many :links, through: :link_lists
  has_many :link_lists
  has_many :pages
  has_many :product_images, through: :products
  has_many :products
  has_many :shipping_countries
  has_many :shipping_rates, through: :shipping_countries
  has_many :subscriber_notifications
  has_many :themes
  has_many :users, dependent: :destroy
  belongs_to :eu_digital_goods_collection, class_name: 'Collection' , foreign_key: "eu_digital_goods_collection_id"
  has_many :webhooks

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :eu_digital_goods_collection_id, numericality: { only_integer: true }, allow_blank: true

  validate :validate_default_collection_id

  def validate_default_collection_id
    if self.eu_digital_goods_collection_id != nil
      collection = Collection.where(shop_id: self.id, id: self.eu_digital_goods_collection_id)
      errors.add(:base, I18n.t('services.shop_services.wrong_collection')) unless collection.present?
    end
  end
end
