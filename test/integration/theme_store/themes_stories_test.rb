require 'test_helper'

class ThemeStore::WelcomeStoriesTest < ActionDispatch::IntegrationTest
  setup do
    use_host THEME_STORE_HOSTNAME
    attributes = {names: ["Pipeline", "Blockshop", "Mobilia", "Palo Alto", "Expression", "Ira",
                         "Envy", "Showcase", "California", "Parallax" ],
                industries: ["Other", "Food & Drink", "Food & Drink", "Sports & Recreation",
                             "Sports & Recreation", "Clothing & Fashion", "Health & Beauty", 
                             "Health & Beauty", "Art & Photography", "Jewelry & Accessories" ],
                prices: [ 140, 140, 160, 0, 150, 160, 120, 180, 180, 0 ],
                styles: ["Cool", "Dark", "Warm", "Bold", "Coffee", "Classic", "Travel",
                         "Spring", "Standfort", "Outdoors"] }
    partner = ThemeServices::CreatePartner.run(name: "Magaz.com", website_url: "https://magaz.com")
    archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
    10.times do |n|
      theme = Theme.new
      ThemeServices::ImportFromArchive
        .call(archive_path: archive_path,
              theme: theme,
              theme_attributes: {name: attributes[:names][n],
                                 price: attributes[:prices][n],
                                 partner_id: partner.result.id})
      theme.theme_styles.first.update_attributes(industry: attributes[:industries][n], name: attributes[:styles][n])
    end
    @style = ThemeStyle.first
  end

  test "should get index" do
    visit theme_store_themes_path
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'All'
    assert page.has_content? 'Choose a theme for your online store'
    assert page.has_content? 'Sell your own theme'
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
    click_link "#{@style.theme.name} — #{@style.name}"
    assert current_path == "/style/#{@style.id}"
  end

  test "should get style" do
    visit theme_store_style_path(@style)
    assert current_path == "/style/#{@style.id}"
    assert page.has_content? 'Themes Store'
    assert page.has_content? 'All'
    assert page.has_content? @style.theme.name
    assert page.has_content? @style.theme.price
    assert page.has_content? @style.name
    assert page.has_content? @style.theme.partner.name
    assert page.has_content? 'Start your free 14-day trial today!'
    assert page.has_content? 'Template categories'
  end


end