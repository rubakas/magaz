module MagazCore
  module ShopServices
    class CreateEvent
      include MagazCore::Concerns::Service
      attr_accessor :event

      def call(subject:, message:, verb:)
        @event = subject.events.new
        event_name = [verb, class_name(subject: subject).downcase, 'event'].join(" ")

        MagazCore::Event.connection.transaction do
          begin
            _create_event!(subject: subject, event: @event,
                           message: message, verb: verb)
            ActiveSupport::Notifications.publish(event_name, event: @event) || fail(ArgumentError)
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ArgumentError
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def class_name(subject:)
        subject.class.name.split('::').last
      end

      def _create_event!(subject:, event:, message:, verb:)
        arguments = Array.new
        case class_name(subject: subject)
        when "Article"
          shop_id = subject.blog.shop_id
          arguments << subject.title
        when "Blog"
          shop_id = subject.shop_id
        when "Comment"
          shop_id = subject.article.blog.shop_id
        when "Checkout"
          shop_id = subject.customer.shop_id
        when "Product"
          shop_id = subject.shop_id
          arguments << subject.name
        when "Collection"
          shop_id = subject.shop_id
          arguments << subject.name
        when "Page"
          shop_id = subject.shop_id
          arguments << subject.title
        else
          fail(ArgumentError)
        end

        event.update_attributes!(subject_type: subject.class.name, arguments: arguments,
                                 message: message, shop_id: shop_id,
                                 verb: verb) || fail(ArgumentError)
      end
    end
  end
end