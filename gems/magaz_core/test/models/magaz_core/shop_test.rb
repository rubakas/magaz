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
    should have_many(:blogs).dependent(:destroy)
    should have_many(:collections).dependent(:destroy)
    should have_many(:comments)
    should have_many(:checkouts)
    should have_many(:customers)
    should have_many(:files).dependent(:destroy)
    should have_many(:links)
    should have_many(:link_lists).dependent(:destroy)
    should have_many(:pages).dependent(:destroy)
    should have_many(:products).dependent(:destroy)
    should have_many(:shipping_countries).dependent(:destroy)
    should have_many(:shipping_rates)
    should have_many(:themes).dependent(:destroy)
    should have_many(:users).dependent(:destroy)
    should have_many(:subscriber_notifications).dependent(:destroy)
    should have_many(:email_templates).dependent(:destroy)
    should belong_to(:eu_digital_goods_collection)
    should have_many(:events).dependent(:destroy)
    should have_many(:webhooks).dependent(:destroy)

    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
    should validate_inclusion_of(:abandoned_checkout_time_delay).in_array(MagazCore::Shop::ABANDONED_CHECKOUT_TIME_DELAY)
    should validate_inclusion_of(:email_marketing_choice).in_array(MagazCore::Shop::EMAIL_MARKETING_CHOICE)

    setup do
      @shop_params = { name: 'example42' }
      @user_params = { first_name: 'First' , last_name: 'Last', email: 'email@mail.com', password: 'password' }
      @default_theme = build(:theme)
      # archive_path = ::File.expand_path('./../../../fixtures/files/valid_theme.zip', __FILE__)
      # MagazCore::ThemeServices::ImportFromArchive
      #   .call(archive_path: archive_path,
      #         theme: @default_theme,
      #         theme_attributes: { name: 'Default' })
      @create_service = MagazCore::ShopServices::Create.call(shop_params: @shop_params,
                                                             user_params: @user_params)
      @shop = @create_service.shop
      @user = @create_service.user

      @comment = create(:comment, article: @article)
      @file = create(:file, shop: @shop)
      @product = create(:product, shop: @shop)
      @shipping_country = create(:shipping_country, shop: @shop)
      @shipping_rate = create(:shipping_rate, shipping_country: @shipping_country)
      @collection = create(:collection, shop: @shop, handle: "handle1")
      @tax_override = create(:tax_override, shipping_country: @shipping_country)
      @subscriber_notification = create(:subscriber_notification, shop: @shop)
      @event = create(:event, shop: @shop, subject: @product)
      @webhook = create(:webhook, shop: @shop)
    end

    #SCORE: 1
    test "should destroy with shop" do
      assert_equal 1, MagazCore::User.count
      assert_equal 1, MagazCore::Blog.count
      assert_equal 1, MagazCore::Article.count
      assert_equal 1, MagazCore::Comment.count
      assert_equal 1, MagazCore::File.count
      assert_equal 2, MagazCore::Page.count
      assert_equal 4, MagazCore::Link.count
      assert_equal 2, MagazCore::LinkList.count
      assert_equal 1, MagazCore::Product.count
      assert_equal 1, MagazCore::ShippingCountry.count
      assert_equal 1, MagazCore::ShippingRate.count
      assert_equal 2, MagazCore::Collection.count
      assert_equal 1, MagazCore::TaxOverride.count
      assert_equal 1, MagazCore::SubscriberNotification.count
      assert_equal 1, MagazCore::Event.count
      assert_equal 1, MagazCore::Webhook.count

      @shop.destroy

      assert_equal 0, MagazCore::User.count
      assert_equal 0, MagazCore::Blog.count
      assert_equal 0, MagazCore::Article.count
      assert_equal 0, MagazCore::Comment.count
      assert_equal 0, MagazCore::File.count
      assert_equal 0, MagazCore::Page.count
      assert_equal 0, MagazCore::Link.count
      assert_equal 0, MagazCore::LinkList.count
      assert_equal 0, MagazCore::Product.count
      assert_equal 0, MagazCore::ShippingCountry.count
      assert_equal 0, MagazCore::ShippingRate.count
      assert_equal 0, MagazCore::Collection.count
      assert_equal 0, MagazCore::TaxOverride.count
      assert_equal 0, MagazCore::SubscriberNotification.count
      assert_equal 0, MagazCore::Event.count
      assert_equal 0, MagazCore::Webhook.count
    end
  end
end
