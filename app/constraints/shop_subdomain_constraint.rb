class ShopSubdomainConstraint
  def self.matches?(request)
    request.subdomain.present? && 
      request.subdomain != "www" &&
      HOSTNAME == request.domain
  end
end