class Constraints::ShopSubdomainConstraint
  def self.matches?(request)
    request.subdomain.present? && 
      request.subdomain != "www" &&
      request.domain(2) == HOSTNAME
  end
end