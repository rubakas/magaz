require 'factory_bot'
FactoryBot.find_definitions

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
end
