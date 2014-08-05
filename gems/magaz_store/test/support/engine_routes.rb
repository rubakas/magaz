class ActionController::TestCase
  setup do
    @routes = MagazStore::Engine.routes
  end
end