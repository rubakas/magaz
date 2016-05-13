require 'sidekiq'


class VisibilityWorker
  include Sidekiq::Worker

  def perform(klass)
    klass.pending_publishing.each do |pp|
      pp.publish_if_pending!
    end
  end
end
