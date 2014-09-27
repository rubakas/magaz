require 'capybara/rails'
require 'capybara/webkit'

# silence 'QNetworkReplyImplPrivate::error'
filtered_io = StringIO.new
filtered_io.instance_eval do
  def write(string)
    if string.include? 'QNetworkReplyImplPrivate::error'
      STDERR.write('')
    else
      STDERR.write(string)
    end
  end
end

Capybara.register_driver :webkit_silent do |app|
  Capybara::Webkit::Driver.new(app, :stderr => filtered_io)
end
Capybara.javascript_driver = :webkit_silent

# Capybara.javascript_driver = :poltergeist

Capybara.run_server = true

Capybara.configure do |config|
  config.match = :one
  config.exact_options = true
  config.ignore_hidden_elements = true
  config.visible_text_only = true
end

def parallel_capybara_server_port
  Capybara.server_port = 9887 + ENV['TEST_ENV_NUMBER'].to_i
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end