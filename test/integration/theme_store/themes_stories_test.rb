require 'test_helper'

class ThemeStore::WelcomeStoriesTest < ActionDispatch::IntegrationTest
  setup do
    use_host THEME_STORE_HOSTNAME
    load "#{Rails.root}/db/seeds.rb"
    @style            = ThemeStyle.first
    @styles           = ThemeStyle.all
    @free_styles      = ThemeStyle.themes_price_category("free")
    @premium_styles   = ThemeStyle.themes_price_category("premium")
    @industry_styles  = ThemeStyle.industry_category("Food & Drink")
    @partner_style    = @style.theme.partner.theme_styles.with_exception_of(@style).take(3).first
  end

  test "should get index" do
    visit theme_store_themes_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'All'
    assert page.has_content? 'Choose a theme for your online store'
    assert page.has_content? "#{@style.theme.name} — #{@style.name}"
    assert page.has_content? "#{@style.theme.price}$"
    assert page.has_content? 'Sell your own theme'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
    click_link "#{@style.theme.name} — #{@style.name}"
    assert current_path == "/theme/#{@style.theme.id}/style/#{@style.id}"
  end

  test "images should be clickable" do
    visit theme_store_themes_path
    find("img[alt='#{@style.full_theme_style_name}']").click
    assert current_path == "/theme/#{@style.theme.id}/style/#{@style.id}"
    find("img[alt='#{@partner_style.full_theme_style_name}']").click
    assert current_path == "/theme/#{@partner_style.theme.id}/style/#{@partner_style.id}"
  end

  test "should get style" do
    visit theme_store_style_path(id: @style.theme.id, style_id: @style.id)
    assert current_path == "/theme/#{@style.theme.id}/style/#{@style.id}"
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'All'
    assert page.has_content? @style.theme.name
    assert page.has_content? @style.theme.price
    assert page.has_content? @style.name
    assert page.has_content? @style.theme.partner.name
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end

  test "should filter and sort styles" do
    visit theme_store_themes_path
    click_link "Free"
    @free_styles.each do |style|
      assert page.has_content? style.name
    end
    click_link "Premium"
    @premium_styles.each do |style|
      assert page.has_content? style.name
    end
    click_link "All", match: :first
    @styles.each do |style|
      assert page.has_content? style.name
    end
    click_link "All Industries"
    click_link "Food & Drink", match: :first
    @industry_styles.each do |style|
      assert page.has_content? style.name
    end
    click_link "All Industries"

    within(".dropdown-menu") do
      click_link "All Industries"
    end

    @styles.each do |style|
      assert page.has_content? style.name
    end
  end

  test "should get author styles" do
    visit theme_store_author_path(@style.theme.partner)
    assert current_path == "/authors/#{@style.theme.partner.id}"
    assert page.has_content? "All of #{@style.theme.partner.name}'s Themes"
    assert page.has_content? "Go to their website"
    assert page.has_css?('ul.pagination')
  end
end
