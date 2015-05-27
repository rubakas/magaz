module MagazStoreAdmin
  class DashboardController < MagazStoreAdmin::ApplicationController
    include MagazCore::Concerns::Authenticable

    def index
      @events = current_shop.events.all
    end
  end
end
