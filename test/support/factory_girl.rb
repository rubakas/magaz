require 'factory_girl'
FactoryGirl.find_definitions

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end