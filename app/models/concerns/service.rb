module Concerns
  module Service
    extend ActiveSupport::Concern

    included do
      def self.call(*args)
        instance = new
        instance.call(*args)
        instance
      end
    end

  end
end
