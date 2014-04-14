module Authenticable 
  extend ActiveSupport::Concern
  
  included do
    before_action :authentication_required
    layout 'admin'
  end

  protected

  def authentication_required
    redirect_to new_admin_session_url unless current_user
  end

  def current_user
    @current_user ||= Shop.find_by_id(session[:user_id])
  end
end