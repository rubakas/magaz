module MagazCore
  module Concerns
    module Authenticable
      extend ActiveSupport::Concern

      included do
        before_action :authentication_required
      end

      protected

      def authentication_required
        redirect_to new_admin_session_url unless current_user
      end

      def current_user
        @current_user ||= MagazCore::Shop.find_by_subdomain(request.subdomain).users.find_by_id(session[:user_id])
      end
    end
  end
end