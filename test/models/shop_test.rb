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
  should have_many :events
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
