ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/pride"

# all staff moved into support folder
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

# require ::File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "minitest/pride"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class CarrierWave::Mount::Mounter
  def store!
  end
end

class ActiveSupport::TestCase
include ActionDispatch::TestProcess

  fixtures :all
  CarrierWave.root = Rails.root
end