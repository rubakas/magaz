module CurrentShopAccess 
  extend ActiveSupport::Concern

  included do
    helper_method :current_shop
  end

  protected
  
  def current_shop
    Shop.find_by_subdomain(request.subdomain)
  end
end