require 'test_helper'

class EmailTemplatesStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    @email_template = create(:email_template, shop: @shop)
    click_link "Settings"
    click_link "Notifications"
  end

  test "templates list" do
    assert page.has_content? @email_template.name
  end

  test "edit template" do
    click_link(@email_template.name, match: :first)
    fill_in 'email_template_title', with: @email_template.name
    fill_in 'email_template_body', with: 'test test test'
    click_button 'Save'
    assert page.has_content? 'Email template was successfully updated.'
  end
end