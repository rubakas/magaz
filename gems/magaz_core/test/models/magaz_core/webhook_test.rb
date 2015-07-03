require 'test_helper'

module MagazCore
  class WebhookTest < ActiveSupport::TestCase

    should belong_to(:shop)
    should have_many(:events)
    should validate_inclusion_of(:topic).in_array(MagazCore::Webhook::Topics::WEBHOOKS_TOPICS_LIST)
    should validate_inclusion_of(:format).in_array(MagazCore::Webhook::FORMAT_CHOICE)
    should validate_presence_of(:address)
    should allow_value("https://vk.com/im").for(:address)
    should_not allow_value("vk.com").for(:address)

  end
end
