module MagazCore
  module Concerns
    module Visibility 
      extend ActiveSupport::Concern

      included do
        scope :published, -> { where(publish_on: nil, published_at: (Time.at(0)..Time.now)) }
        scope :not_published, -> { where("publish_on >= ?", Time.now).where(published_at: nil) }
        scope :pending_publishing, -> { where("publish_on <= ?", Time.now).where(published_at: nil) }
        before_validation :_force_visibility_status
        after_save :_schedule_publishing_job
      end

      def publish_if_pending!
        if pending_publishing?
          published_at = Time.now #TODO
          publish_on = nil
          save!
        else
          fail "Publishing is not pending"
        end
      end

      def published?
        !published_at.nil? && published_at < Time.now
      end

      def pending_publishing?
        published_at.nil? && publish_on < Time.now
      end

      private

      def _force_visibility_status
        if !publish_on.blank? && published_at.blank? # publish in future
          # create bg job or something
        elsif publish_on.blank? && !published_at.blank? # already published?
          # do nothing
        elsif !publish_on.blank? && !published_at.blank?
          fail 'Impossible visibility state'
        else # publish_on.blank? && published_at.blank?
          # hidden
        end
      end

      def _schedule_publishing_job
        unless publish_on.blank?
          VisibilityWorker.perform_at(publish_on, self.class)
        end
      end

    end
  end
end