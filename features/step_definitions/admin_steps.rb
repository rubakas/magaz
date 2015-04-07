Given(/^shop admin logged in$/) do
  hostname = "#{@shop.subdomain}.#{HOSTNAME}"
  host! hostname
  Capybara.app_host = "http://" + hostname
  Capybara.default_host = Capybara.app_host

  visit '/admin/session/new'
  fill_in 'Email', with: @shop.email
  fill_in 'Password', with: 'password'
  click_button 'Sign in'
end
