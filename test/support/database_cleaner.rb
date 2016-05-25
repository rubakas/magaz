require 'database_cleaner'

DatabaseCleaner.strategy = :deletion

class ActiveSupport::TestCase
  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end
end

class ActionDispatch::IntegrationTest
  self.use_transactional_tests = false
end