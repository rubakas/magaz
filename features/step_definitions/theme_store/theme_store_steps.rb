Given(/^themes exist$/) do
  @existing_themes = create_list(:theme, 20)
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
  pending # express the regexp above with the code you wish you had
end

Given(/^clicks theme name$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^must be on theme page$/) do
  pending # express the regexp above with the code you wish you had
end