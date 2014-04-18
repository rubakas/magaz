class ThemeStoreSubdomainConstraint
  def self.matches?(request)
    request.subdomain.present? && 
      "themes" == request.subdomain &&
      HOSTNAME == request.domain
  end
end