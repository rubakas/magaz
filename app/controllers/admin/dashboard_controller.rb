class Admin::DashboardController < Admin::ApplicationController
  include Concerns::Authenticable

  def index
    @events = current_shop.events.all
  end
end
