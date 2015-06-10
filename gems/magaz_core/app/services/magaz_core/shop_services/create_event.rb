module MagazCore
  module ShopServices
    class CreateEvent
      include MagazCore::Concerns::Service
      attr_accessor :event

      def call(subject:, topic:, current_user:)
        @event = subject.events.new
        @current_user = current_user

        MagazCore::Event.connection.transaction do
          begin
            _create_event!(subject: subject, event: @event, topic: topic)
          rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ArgumentError
            raise ActiveRecord::Rollback
          end
        end
      end

      private

      def class_name(subject:)
        subject.class.name.split('::').last
      end

      # def message(action:, subject:)
      #   I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.#{action}'), subject: I18n.t('magaz_store_admin.events.#{subject}'), user_name: @current_user.full_name)
      # end

      def _create_event!(subject:, event:, topic:)
        arguments = Array.new
        case topic
        when "create_article_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.article'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::CREATE
          shop_id = subject.blog.shop_id
          arguments << subject.title
        when "update_article_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.article'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.blog.shop_id
          arguments << subject.title
        when "delete_article_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.article'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::DESTROY
          shop_id = subject.blog.shop_id
          arguments << subject.title

        when "create_blog_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.blog'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::CREATE
          shop_id = subject.shop_id
        when "update_blog_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.blog'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.shop_id
        when "delete_blog_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.blog'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::DESTROY
          shop_id = subject.shop_id

        when "create_comment_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.comment'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::CREATE
          shop_id = subject.article.blog.shop_id
        when "update_comment_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.blog'), subject: I18n.t('magaz_store_admin.events.comment'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.article.blog.shop_id
        when "delete_comment_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.comment'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::DESTROY
          shop_id = subject.article.blog.shop_id

        when "update_order_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.order'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.customer.shop_id
        when "delete_order_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.order'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::DESTROY
          shop_id = subject.customer.shop_id
        when "placed_order_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.placed'), subject: I18n.t('magaz_store_admin.events.order'), user_name: [@current_user.first_name, @current_user.last_name].map(&:capitalize).join(" "))
          verb = MagazCore::Event::Verbs::PLACED
          arguments << subject.email
          shop_id = subject.customer.shop_id

        when "create_product_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.product'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::CREATE
          shop_id = subject.shop_id
          arguments << subject.name
        when "update_product_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.product'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.shop_id
          arguments << subject.name
        when "delete_product_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.product'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::DESTROY
          shop_id = subject.shop_id
          arguments << subject.name

        when "create_collection_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.collection'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::CREATE
          shop_id = subject.shop_id
          arguments << subject.name
        when "update_collection_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.collection'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.shop_id
          arguments << subject.name
        when "delete_collection_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.collection'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::DESTROY
          shop_id = subject.shop_id
          arguments << subject.name

        when "create_page_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.page'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::CREATE
          shop_id = subject.shop_id
          arguments << subject.title
        when "update_page_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.page'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.shop_id
          arguments << subject.title
        when "delete_page_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.page'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::DESTROY
          shop_id = subject.shop_id
          arguments << subject.title

        when "create_customer_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.customer'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::CREATE
          shop_id = subject.shop_id
          arguments << subject.email
        when "update_customer_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.customer'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.shop_id
          arguments << subject.email
        when "delete_customer_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.customer'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::DESTROY
          shop_id = subject.shop_id
          arguments << subject.email

        when "create_user_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.user'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::CREATE
          shop_id = subject.shop_id
          arguments << subject.email
        when "update_user_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.user'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.shop_id
          arguments << subject.email
        when "delete_user_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.user'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::DESTROY
          shop_id = subject.shop_id
          arguments << subject.email

        when "create_webhook_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.webhook'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::CREATE
          shop_id = subject.shop_id
        when "update_webhook_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.webhook'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.shop_id
        when "delete_webhook_event"
          message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.webhook'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::DESTROY
          shop_id = subject.shop_id

        when "update_shop_event"
          message = I18n.t('magaz_store_admin.evthe managementents.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.shop'), user_name: @current_user.full_name)
          verb = MagazCore::Event::Verbs::UPDATE
          shop_id = subject.id
          arguments << subject.name
          event.update_attributes(subject_id: shop_id)
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