require 'test_helper'

class Admin::SettingsStoriesTest < ActionDispatch::IntegrationTest
  setup do
    login
    click_link "Settings"
  end

  test "settings form" do
    assert page.has_content? 'Shop Settings'
  end

  test "update shop failure" do
    fill_in 'Name', with: ''
    fill_in 'Email', with: ''
    click_button 'Save Shop'
    assert page.has_content? '3 errors prohibited this shop from being saved:'
  end

  #need to rewrite this soon
  test "update shop success" do
    fill_in 'Name', with: 'Updated Name'
    fill_in 'Email', with: 'update@mail.com'
    click_button 'Save Shop'
    save_and_open_page
    assert page.has_no_content? 'prohibited this shop from being saved:'
  end

end