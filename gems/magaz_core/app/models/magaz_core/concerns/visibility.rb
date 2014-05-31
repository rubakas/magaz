module MagazCore
  module Concerns
    module Visibility 
      extend ActiveSupport::Concern

      included do
        scope :published, -> { where(publish_on: nil, published_at: (Time.at(0)..Time.now)) }

        #TODO perhaps it should cover nil, nil case?
        scope :not_published, -> { where("publish_on >= ?", Time.now).where(published_at: nil) }
        before_validation :force_visibility_status
      end

      def published?
        !published_at.nil? && published_at < Time.now
      end

      private

      def force_visibility_status
        if !publish_on.blank? && published_at.blank? # publish in future
          # create bg job or something
        elsif publish_on.blank? && !published_at.blank? # already published?
          # do nothing
        elsif !publish_on.blank? && !published_at.blank?
          fail 'Impossible state'
        else # publish_on.blank? && published_at.blank?
          # hidden
        end
      end

    end
  end
end