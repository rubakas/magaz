require 'test_helper'

class ThemeStore::WelcomeStoriesTest < ActionDispatch::IntegrationTest
  setup do
    use_host THEME_STORE_HOSTNAME
    @partner = create(:partner)
    6.times do |n|
      archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
      theme = Theme.new
      theme_attributes = { name: "New theme#{n}", price: 7.5*n , industry: "Other", partner_id: @partner.id}    
      ThemeServices::ImportFromArchive.call archive_path: archive_path,
                                                         theme: theme,
                                                         theme_attributes: theme_attributes
     end
  end
  
  test "should get homepage" do
    visit theme_store_homepage_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'All'
    assert page.has_content? 'Choose a theme for your online store'
    assert page.has_content? 'Sell your own theme'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end

  test "should get template_page" do
    visit theme_store_template_page_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'All'
    assert page.has_content? 'Find the Perfect Website Template for Your Home and Garden Business'
    assert page.has_content? 'Sell your own theme'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end

  test "should get theme_page" do
    visit theme_store_theme_page_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'All'
    assert page.has_content? 'Free'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
    click_link 'Preview in your store'
    assert page.has_content? 'You can now preview the theme'
    visit theme_store_theme_page_path
    click_link 'View Demo'
    assert page.has_content? 'desktop'
    visit theme_store_theme_page_path
    click_link 'Author'
    assert page.has_content? "All Author's Themes"
    visit theme_store_theme_page_path
    click_link 'Health & Beaty templates'
    visit theme_store_theme_page_path

  end
  
  test "should get learn_more" do
    visit theme_store_learn_more_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'Sell your own theme'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end

  test "should get authors_themes" do
    visit theme_store_authors_themes_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? "All Author's Themes"
    assert page.has_content? 'Template categories'
  end

  test "should get demo" do
    visit theme_store_demo_path
    assert page.has_content? 'To the Theme'
    assert page.has_selector? 'iframe'
  end

  test "should get installing" do
    visit theme_store_installing_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? "You're about to install Jumpstart to store-name.magaz.com"
    assert page.has_content? 'Template categories'
  end

  test "should get login" do
    visit theme_store_login_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'Log in to your store'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end

  test "should get preview_in_store" do
    visit theme_store_preview_in_store_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'You can now preview the theme'
    assert page.has_content? 'Template categories'
  end

end
