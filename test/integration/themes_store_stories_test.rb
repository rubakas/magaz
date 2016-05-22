require 'test_helper'

class ThemesStoreStoriesTest < ActionDispatch::IntegrationTest
  
  test "should get homepage" do
    visit homepage_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'All'
    assert page.has_content? 'Choose a theme for your online store'
    assert page.has_content? 'Sell your own theme'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end

  test "should get template_page" do
    visit template_page_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'All'
    assert page.has_content? 'Find the Perfect Website Template for Your Home and Garden Business'
    assert page.has_content? 'Sell your own theme'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end

  test "should get theme_page" do
    visit theme_page_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'All'
    assert page.has_content? 'Name'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end
  
  test "should get learn_more" do
    visit learn_more_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'Sell your own theme'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end

  test "should get authors_themes" do
    visit authors_themes_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? "All Author's Themes"
    assert page.has_content? 'Template categories'
  end

  test "should get demo" do
    visit demo_path
    assert page.has_content? 'To the Theme'
    assert page.has_content? 'Area for preview Theme'
  end

  test "should get installing" do
    visit installing_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? "You're about to install Jumpstart to store-name.magaz.com"
    assert page.has_content? 'Template categories'
  end

  test "should get login" do
    visit login_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'Log in to your store'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end

  test "should get preview_in_store" do
    visit preview_in_store_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'You can now preview the theme'
    assert page.has_content? 'Template categories'
  end

end