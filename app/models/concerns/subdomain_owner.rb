module Concerns
  module SubdomainOwner
    extend ActiveSupport::Concern

    included do

      # redundant - in password authenticable
      # validates :name, presence: true, uniqueness: true
      validates :subdomain, presence: true,
                            uniqueness: true,
                            format: { with: /[-a-z0-9]/ }

      before_validation :force_subdomain_format, on: :create
    end

    private

    def force_subdomain_format
      return if name.nil?

      #TODO:  extract any special symbols
      self.subdomain = name.downcase.parameterize
      #TODO:  add uniqueness generator
      #TODO:  ensure latin characters only?
    end

  end
end
