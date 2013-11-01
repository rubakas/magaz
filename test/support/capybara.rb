require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.run_server = true

def parallel_capybara_server_port
  Capybara.server_port = 9887 + ENV['TEST_ENV_NUMBER'].to_i
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end