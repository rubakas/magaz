class MagazCore::AdminServices::Event::CreateEvent
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

  def _create_event!(subject:, event:, topic:)
    arguments = Array.new
    case topic
    when MagazCore::Webhook::Topics::CREATE_ARTICLE_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.article'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::CREATE
      shop_id = subject.blog.shop_id
      arguments << subject.title
    when MagazCore::Webhook::Topics::UPDATE_ARTICLE_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.article'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::UPDATE
      shop_id = subject.blog.shop_id
      arguments << subject.title
    when MagazCore::Webhook::Topics::DELETE_ARTICLE_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.article'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::DESTROY
      shop_id = subject.blog.shop_id
      arguments << subject.title

    when MagazCore::Webhook::Topics::CREATE_BLOG_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.blog'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::CREATE
      shop_id = subject.shop_id
    when MagazCore::Webhook::Topics::UPDATE_BLOG_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.blog'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::UPDATE
      shop_id = subject.shop_id
    when MagazCore::Webhook::Topics::DELETE_BLOG_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.blog'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::DESTROY
      shop_id = subject.shop_id

    when MagazCore::Webhook::Topics::CREATE_COMMENT_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.comment'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::CREATE
      shop_id = subject.article.blog.shop_id
    when MagazCore::Webhook::Topics::UPDATE_COMMENT_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.blog'), subject: I18n.t('magaz_store_admin.events.comment'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::UPDATE
      shop_id = subject.article.blog.shop_id
    when MagazCore::Webhook::Topics::DELETE_COMMENT_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.comment'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::DESTROY
      shop_id = subject.article.blog.shop_id

    when MagazCore::Webhook::Topics::UPDATE_ORDER_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.order'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::UPDATE
      shop_id = subject.customer.shop_id
    when MagazCore::Webhook::Topics::DELETE_ORDER_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.order'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::DESTROY
      shop_id = subject.customer.shop_id
    when MagazCore::Webhook::Topics::PLACED_ORDER_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.placed'), subject: I18n.t('magaz_store_admin.events.order'), user_name: [@current_user.first_name, @current_user.last_name].map(&:capitalize).join(" "))
      verb = MagazCore::Event::Verbs::PLACED
      arguments << subject.email
      shop_id = subject.customer.shop_id

    when MagazCore::Webhook::Topics::CREATE_PRODUCT_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.product'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::CREATE
      shop_id = subject.shop_id
      arguments << subject.name
    when MagazCore::Webhook::Topics::UPDATE_PRODUCT_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.product'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::UPDATE
      shop_id = subject.shop_id
      arguments << subject.name
    when MagazCore::Webhook::Topics::DELETE_PRODUCT_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.product'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::DESTROY
      shop_id = subject.shop_id
      arguments << subject.name

    when MagazCore::Webhook::Topics::CREATE_COLLECTION_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.collection'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::CREATE
      shop_id = subject.shop_id
      arguments << subject.name
    when MagazCore::Webhook::Topics::UPDATE_COLLECTION_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.collection'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::UPDATE
      shop_id = subject.shop_id
      arguments << subject.name
    when MagazCore::Webhook::Topics::DELETE_COLLECTION_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.collection'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::DESTROY
      shop_id = subject.shop_id
      arguments << subject.name

    when MagazCore::Webhook::Topics::CREATE_PAGE_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.page'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::CREATE
      shop_id = subject.shop_id
      arguments << subject.title
    when MagazCore::Webhook::Topics::UPDATE_PAGE_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.page'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::UPDATE
      shop_id = subject.shop_id
      arguments << subject.title
    when MagazCore::Webhook::Topics::DELETE_PAGE_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.page'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::DESTROY
      shop_id = subject.shop_id
      arguments << subject.title

    when MagazCore::Webhook::Topics::CREATE_CUSTOMER_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.customer'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::CREATE
      shop_id = subject.shop_id
      arguments << subject.email
    when MagazCore::Webhook::Topics::UPDATE_CUSTOMER_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.customer'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::UPDATE
      shop_id = subject.shop_id
      arguments << subject.email
    when MagazCore::Webhook::Topics::DELETE_CUSTOMER_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.customer'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::DESTROY
      shop_id = subject.shop_id
      arguments << subject.email

    when MagazCore::Webhook::Topics::CREATE_USER_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.user'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::CREATE
      shop_id = subject.shop_id
      arguments << subject.email
    when MagazCore::Webhook::Topics::UPDATE_USER_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.user'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::UPDATE
      shop_id = subject.shop_id
      arguments << subject.email
    when MagazCore::Webhook::Topics::DELETE_USER_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.user'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::DESTROY
      shop_id = subject.shop_id
      arguments << subject.email

    when MagazCore::Webhook::Topics::CREATE_WEBHOOK_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.created'), subject: I18n.t('magaz_store_admin.events.webhook'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::CREATE
      shop_id = subject.shop_id
    when MagazCore::Webhook::Topics::UPDATE_WEBHOOK_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.updated'), subject: I18n.t('magaz_store_admin.events.webhook'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::UPDATE
      shop_id = subject.shop_id
    when MagazCore::Webhook::Topics::DELETE_WEBHOOK_EVENT
      message = I18n.t('magaz_store_admin.events.message', action: I18n.t('magaz_store_admin.events.deleted'), subject: I18n.t('magaz_store_admin.events.webhook'), user_name: @current_user.full_name)
      verb = MagazCore::Event::Verbs::DESTROY
      shop_id = subject.shop_id

    when MagazCore::Webhook::Topics::UPDATE_SHOP_EVENT
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
