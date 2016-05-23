require 'test_helper'

module Admin
  class WebhooksStoriesTest < ActionDispatch::IntegrationTest
    setup do
      login
      @webhook = create(:webhook, shop: @shop)
      click_link 'Settings'
      click_link 'Webhooks'
    end

    test 'Webhooks list' do
      assert page.has_content? 'Webhooks'
      assert page.has_content? @webhook.topic
      assert page.has_content? @webhook.address
      assert page.has_content? @webhook.format
    end
    
# score=1
    test 'should create webhook' do
      click_link 'Create Webhook'
      fill_in 'webhook_address', with: 'https://www.google.com.ua/'
      select('Collection creation', :from => 'webhook_topic')
      select('XML', :from => 'webhook_format')
      click_button 'Create Webhook'
      assert page.has_content? 'Webhook was successfully created.'
    end

# score=1
    test 'should update webhook' do
      click_link(@webhook.topic, match: :first)
      fill_in 'webhook_address', with: 'https://www.google.com.ua/'
      select('Product deletion', :from => 'webhook_topic')
      select('XML', :from => 'webhook_format')
      click_button 'Update Webhook'
      assert page.has_content? 'Webhook was successfully updated.'
    end

# score=1
    test 'should not update webhook' do
      click_link(@webhook.topic, match: :first)
      fill_in 'webhook_address', with: ''
      select('Product deletion', :from => 'webhook_topic')
      select('XML', :from => 'webhook_format')
      click_button 'Update Webhook'
      assert page.has_content? "2 errors"
    end

# score=1
    test 'should delete webhook' do
      assert page.has_content? 'Webhooks'
      click_link('Delete', match: :first)
      assert page.has_content? "Webhook was successfully deleted."
    end
  end
end