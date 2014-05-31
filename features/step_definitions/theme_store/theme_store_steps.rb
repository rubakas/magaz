Given(/^themes exist$/) do
  @existing_source_themes = build_list(:theme, 20)
  archive_path = File.expand_path('gems/magaz_core/test/fixtures/files/valid_theme.zip', Rails.root)

  @existing_source_themes.each do |theme|
    MagazCore::ThemeServices::ImportFromArchive
      .call(archive_path: archive_path,
            theme: theme,
            theme_attributes: theme.attributes)
  end
end

Given(/^browsing theme store domain$/) do
  host = "themes.#{HOSTNAME}"
  Capybara.app_host = "http://" + host
  Capybara.default_host = Capybara.app_host
end

Given(/^visit themestore index page$/) do
  visit "/"
end

Given(/^must see themes$/) do
  MagazCore::Theme.sources.limit(9).each do |theme_on_page|
    assert page.has_content? theme_on_page.name
  end
end

Given(/^clicks theme name$/) do
  # save_and_open_page
  # click_link MagazCore::Theme.sources.first.name
end

Given(/^choose to install theme$/) do
  # click_link "Install theme"
end

Given(/^theme must be installed$/) do
  assert_equal MagazCore::Theme.sources.first, @shop.themes.installed.last.source_theme
end