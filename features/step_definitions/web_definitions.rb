Given(/^hostname is "(.*?)"$/) do |host|
  Capybara.app_host = "http://" + host #+ ":" + parallel_capybara_server_port.to_s
  Capybara.default_host = Capybara.app_host
end

When /^I visit "(.*?)"$/ do |location|
  visit(location)
end

When /^I click "(.*?)"$/ do |text|
  click_on(text)
end

When /^fill in "(.*?)" with "(.*?)"$/ do |field, data|
  fill_in field, with: data
end

Then /^I must see text "(.*?)"$/ do |text|
  assert page.has_content?(text), "#{text} text not found"
end

Then /^I must be at "(.*?)"$/ do |location|
  assert_equal location, page.current_path
end
