module MagazCore
  module Concerns
    module CurrentShopAccess
      extend ActiveSupport::Concern

      included do
        helper_method :current_shop
      end

      protected

      def current_shop
        MagazCore::Shop.find_by_subdomain(request.subdomain)
      end
    end
  end
end