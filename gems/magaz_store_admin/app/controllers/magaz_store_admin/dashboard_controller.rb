module MagazStoreAdmin
  class DashboardController < MagazStoreAdmin::ApplicationController
    include MagazCore::Concerns::Authenticable

    def index
      @events = current_shop.self_events.all
    end
  end
end
