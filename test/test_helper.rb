ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
	ActiveRecord::Migration.check_pending!

	# Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
	#
	# Note: You'll currently still have to declare fixtures explicitly in integration tests
	# -- they do not yet inherit this setting
	fixtures :all

	# Add more helper methods to be used by all tests here...
end

Capybara.run_server = true
Capybara.javascript_driver = :webkit

class ActionDispatch::IntegrationTest
	# Make the Capybara DSL available in all integration tests
	include Capybara::DSL
	
	private
	module CustomIntegrationDsl
		def use_js
			Capybara.current_driver = Capybara.javascript_driver
		end

		def set_host (host)
  		host! host
  		Capybara.app_host = "http://" + host + ":" + Capybara.current_session.server.port.to_s
  		Capybara.default_host = Capybara.app_host
		end

		def login_as(shop_name: shop_name, email: email, password: password)
			use_js
			set_host HOSTNAME_SITE
			visit '/'
			click_link 'Sign in'
			fill_in 'Your shop name', with: shop_name
			fill_in 'Email address', with: email
			fill_in 'Password', with: password
			
			set_host "#{shop_name}.#{HOSTNAME_SHOP}"
			click_button 'Sign in'
		end
	end

	include CustomIntegrationDsl
end

class ActionController::TestCase
	private
	module CustomControllerDsl
		def session_for_shop(shop)
			session[:shop_id] = shop.id
		end
	end

	include CustomControllerDsl
end
