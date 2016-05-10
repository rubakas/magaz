class Admin::DashboardController < Admin::ApplicationController
  include MagazCore::Concerns::Authenticable

  def index
    @events = current_shop.events.all
  end
end
