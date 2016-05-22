module Store
  class WelcomeController < Store::ApplicationController
    def index
      @collections = current_shop.collections
    end
  end
end