module MagazStore
  class WelcomeController < MagazStore::ApplicationController
    def index
      @collections = current_shop.collections
    end
  end
end