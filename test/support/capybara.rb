require 'capybara/rails'

Capybara.run_server = true
Capybara.javascript_driver = :webkit

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end