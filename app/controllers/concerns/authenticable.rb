module Authenticable extend ActiveSupport::Concern
  included do
    before_action :authentication_required
    layout 'admin'
  end

  protected

  def authentication_required
    redirect_to new_session_path unless current_shop
  end

  def current_shop
    @current_shop ||= Shop.find_by_id(session[:shop_id])
  end
end