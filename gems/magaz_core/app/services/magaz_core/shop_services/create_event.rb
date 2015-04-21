module MagazCore
  module ShopServices
    class CreateEvent
      include MagazCore::Concerns::Service
      attr_accessor :event

      def call(subject:, message:, description:, path:, verb:)
        @event = subject.events.new

        MagazCore::Event.connection.transaction do
          begin
            _create_event!(subject: subject, event: @event,
                           message: message, description: description,
                           path: path, verb: verb)
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ArgumentError
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def _create_event!(subject:, event:, message:, description:, path:, verb:)
        arguments = Array.new
        if subject.class.name.split('::').last == "Product" ||
           subject.class.name.split('::').last == "Collection"
          arguments << subject.name
        end
        if subject.class.name.split('::').last == "Order"
          arguments << subject.line_items
        end
        #full_name = [user.first_name, user.last_name].map(&:capitalize).join(" ")
        #arguments << full_name#user.first_name.join(" ").join(user.last_name)
        event.update_attributes!(subject_type: subject.class.name.split('::').last,
                                 arguments: arguments, message: message, description: description,
                                 shop_id: subject.shop_id, path: path, verb: verb) || fail(ArgumentError)
      end
    end
  end
end