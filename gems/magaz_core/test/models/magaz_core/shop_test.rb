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

require 'test_helper'

module MagazCore
  class ShopTest < ActiveSupport::TestCase

    should have_many(:articles)
    should have_many(:blogs)
    should have_many(:collections)
    should have_many(:comments)
    should have_many(:checkouts)
    should have_many(:customers)
    should have_many(:files)
    should have_many(:links)
    should have_many(:link_lists)
    should have_many(:pages)
    should have_many(:products)
    should have_many(:shipping_countries)
    should have_many(:shipping_rates)
    should have_many(:themes)
    should have_many(:users).dependent(:destroy)
    should have_many(:subscriber_notifications)
    should have_many(:email_templates).dependent(:destroy)
    should belong_to(:eu_digital_goods_collection)
    should have_many(:events)
    should have_many(:webhooks)

    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
    should validate_inclusion_of(:abandoned_checkout_time_delay).in_array(MagazCore::Shop::ABANDONED_CHECKOUT_TIME_DELAY)
    should validate_inclusion_of(:email_marketing_choice).in_array(MagazCore::Shop::EMAIL_MARKETING_CHOICE)

  end
end
