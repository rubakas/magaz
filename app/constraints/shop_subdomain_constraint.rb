class ShopSubdomainConstraint
  def self.matches?(request)
    request.subdomain.present? && 
      request.subdomain != "www" &&
      HOSTNAME_SHOP == request.domain
  end
end