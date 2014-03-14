Given(/^hostname is "(.*?)"$/) do |host|
  Capybara.app_host = "http://" + host #+ ":" + parallel_capybara_server_port.to_s
  Capybara.default_host = Capybara.app_host
end

When /^I visit page "(.*?)"$/ do |location|
  visit(location)
end

When /^click "(.*?)"$/ do |label|
  text = I18n.t(label)
  click_on(text)
end

When /^fill in "(.*?)" with "(.*?)"$/ do |field, data|
  fill_in field, with: data
end

Then /^I must see "(.*?)" translation$/ do |translation|
  text = I18n.t(translation)
  assert page.has_content?(text), "#{translation} text not found"
end

Then /^I must be on page "(.*?)"$/ do |location|
  assert_equal location, page.current_path
end

Then /^email must be sent to "(.*?)"$/ do |address|
  @email = ActionMailer::Base.deliveries.first
  assert_equal address, @email.to.first
end