require 'test_helper'

class SettingsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    click_link "Settings"
  end

  test "settings form" do
    assert page.has_content? 'Shop Settings'
  end

  test "update shop failure" do
    fill_in 'Name', with: ''
    click_button 'Save Shop'
    assert page.has_content? '1 error prohibited this shop from being saved:'
  end

  test "update shop success" do
    fill_in 'Name', with: 'Updated Name'
    click_button 'Save Shop'
    assert page.has_content? 'Shop was successfully updated.'
  end
end
