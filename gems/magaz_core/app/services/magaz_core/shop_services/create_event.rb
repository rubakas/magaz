module MagazCore
  module ShopServices
    class CreateEvent
      include MagazCore::Concerns::Service
      attr_accessor :event

      def call(subject:, message:, verb:, webhook:)
        @event = subject.events.new
        # @webhook = 'some some'
        # event_name = [verb, class_name(subject: subject).downcase, 'event'].join(" ")

        MagazCore::Event.connection.transaction do
          begin
            _create_event!(subject: subject, event: @event,
                           message: message, verb: verb)
            # set_webhook(verb: verb,
            #             subject_type: class_name(subject: subject),
            #             webhook: @webhook)
            ActiveSupport::Notifications.publish('event', event: @event, webhook: webhook) || fail(ArgumentError)
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ArgumentError
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def class_name(subject:)
        subject.class.name.split('::').last
      end

      # def set_webhook(verb:, subject_type:, webhook:)
      #   @constant = [verb.upcase, "_", subject_type.upcase, "_EVENT"].join("")
      #   @webhook = MagazCore::Event::Roles.const_get(@constant)

        # case [subject_type, verb]
        # when ["Article", "create"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Article", "update"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Article", "destroy"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Blog", "create"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Blog", "update"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Blog", "destroy"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Comment", "create"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Comment", "update"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Comment", "destroy"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Collection", "create"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Collection", "update"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Collection", "destroy"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Checkout", "update"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Checkout", "destroy"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Customer", "create"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Customer", "update"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Customer", "destroy"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Product", "create"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Product", "update"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Product", "destroy"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Page", "create"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Page", "update"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Page", "destroy"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["User", "create"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["User", "update"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["User", "destroy"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # when ["Shop", "update"]
        #   @webhook =  MagazCore::Event::Roles::CREATE_ARTICLE_EVENT
        # else
        #   fail(ArgumentError)
        # end
      # end

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
        when "Customer"
          shop_id = subject.shop_id
          arguments << subject.email
        when "User"
          shop_id = subject.shop_id
          arguments << subject.email
        when "Shop"
          shop_id = subject.id
          arguments << subject.name
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