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

Capybara.javascript_driver = :webkit

class ActionDispatch::IntegrationTest
	# Make the Capybara DSL available in all integration tests
	include Capybara::DSL
	
	private
	module CustomIntegrationDsl
		def login_as(shop_name: shop_name, email: email, password: password)
			visit '/'
			click_link 'Sign in'
			fill_in 'Your shop name', with: shop_name
			fill_in 'Email address', with: email
			fill_in 'Password', with: password
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
