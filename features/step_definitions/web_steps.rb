Given(/^browsing domain$/) do
	host = "#{@shop.subdomain}.#{HOSTNAME}"
	Capybara.app_host = "http://" + host
  Capybara.default_host = Capybara.app_host
end