ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/pride"

# Load support files
# Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require "rails/test_help"
require "minitest/pride"

Rails.backtrace_cleaner.remove_silencers!


class CarrierWave::Mount::Mounter
  def store!
  end
end

class ActiveSupport::TestCase
  include ActionDispatch::TestProcess

  fixtures :all
  CarrierWave.root = Rails.root
end