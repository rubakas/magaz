module MagazCore
  module ShopServices
    class CreateEvent
      include MagazCore::Concerns::Service
      attr_accessor :event

      def call(subject:, message:, description:, verb:)
        @event = subject.events.new

        MagazCore::Event.connection.transaction do
          begin
            _create_event!(subject: subject, event: @event,
                           message: message, description: description,
                           verb: verb)
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ArgumentError
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def _create_event!(subject:, event:, message:, description:, verb:)
        arguments = Array.new
        if subject.class.name.split('::').last == "Article"
          shop_id = subject.blog.shop_id
        elsif subject.class.name.split('::').last == "Comment"
          shop_id = subject.article.blog.shop_id
        elsif subject.class.name.split('::').last == "Checkout"
          shop_id = subject.customer.shop_id
        else
          shop_id = subject.shop_id
        end

        if subject.class.name.split('::').last == "Product" ||
           subject.class.name.split('::').last == "Collection"
          arguments << subject.name
        elsif subject.class.name.split('::').last == "Order"
          #arguments << subject.line_items
        elsif subject.class.name.split('::').last == "Page" ||
           subject.class.name.split('::').last == "Article"
          arguments << subject.title
        end

        event.update_attributes!(subject_type: subject.class.name.split('::').last,
                                 arguments: arguments, message: message, description: description,
                                 shop_id: shop_id, verb: verb) || fail(ArgumentError)
      end
    end
  end
end