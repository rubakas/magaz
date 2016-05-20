class StoreServices::CreateEvent < ActiveInteraction::Base

  set_callback :validate, :after, -> {event}
  set_callback :validate, :before, -> {get_class}

  integer :user_id, :shop_id, :subject_id
  string :topic, :subject_class

  validates :user_id, :shop_id, :topic, :subject_id, :subject_class, presence: true
  validates :topic, inclusion: { in: Webhook::Topics.constants.map {|const| Webhook::Topics.const_get(const) }}
  validate :user_exist?, :subject_exist?

  def event
    @event = Event.new
    add_errors if errors.any?
    @event
  end

  def execute
    @subject = @class.find(subject_id)
    @event = @subject.events.new
    @current_user = User.find(user_id)

    Event.connection.transaction do
      begin
        _create_event!
      rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ArgumentError
        raise ActiveRecord::Rollback
      end
    end
    @event
  end

  private

  def add_errors
    errors.full_messages.each do |msg|
      @event.errors.add(:base, msg)
    end
  end

  def get_class
    @class = subject_class.classify.safe_constantize
  end

  def user_exist?
    User.where(id: user_id, shop_id: shop_id).count == 1 || 
      errors.add(:base, I18n.t('services.create_event.user_not_exist'))
  end

  def subject_exist?
    @class.exists?(id: subject_id) || 
      errors.add(:base, I18n.t('services.create_event.subject_not_exist'))
  end

  def _create_event!
    arguments = Array.new
    case topic
    when Webhook::Topics::CREATE_ARTICLE_EVENT
      message = I18n.t('admin.events.message',
                       action: I18n.t('admin.events.created'), 
                       subject: I18n.t('admin.events.article'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::CREATE
      arguments << @subject.title
    when Webhook::Topics::UPDATE_ARTICLE_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.updated'), 
                       subject: I18n.t('admin.events.article'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
      arguments << @subject.title
    when Webhook::Topics::DELETE_ARTICLE_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.deleted'), 
                       subject: I18n.t('admin.events.article'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::DESTROY
      arguments << @subject.title

    when Webhook::Topics::CREATE_BLOG_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.created'),
                       subject: I18n.t('admin.events.blog'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::CREATE
    when Webhook::Topics::UPDATE_BLOG_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.updated'),
                       subject: I18n.t('admin.events.blog'),
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
    when Webhook::Topics::DELETE_BLOG_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.deleted'),
                       subject: I18n.t('admin.events.blog'),
                       user_name: @current_user.full_name)
      verb = Event::Verbs::DESTROY

    when Webhook::Topics::CREATE_COMMENT_EVENT
      message = I18n.t('admin.events.message',
                       action: I18n.t('admin.events.created'),
                       subject: I18n.t('admin.events.comment'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::CREATE
    when Webhook::Topics::UPDATE_COMMENT_EVENT
      message = I18n.t('admin.events.message',
                       action: I18n.t('admin.events.blog'),
                       subject: I18n.t('admin.events.comment'),
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
    when Webhook::Topics::DELETE_COMMENT_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.deleted'),
                       subject: I18n.t('admin.events.comment'),
                       user_name: @current_user.full_name)
      verb = Event::Verbs::DESTROY

    when Webhook::Topics::UPDATE_ORDER_EVENT
      message = I18n.t('admin.events.message',
                       action: I18n.t('admin.events.updated'),
                       subject: I18n.t('admin.events.order'),
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
    when Webhook::Topics::DELETE_ORDER_EVENT
      message = I18n.t('admin.events.message',
                       action: I18n.t('admin.events.deleted'), 
                       subject: I18n.t('admin.events.order'),
                       user_name: @current_user.full_name)
      verb = Event::Verbs::DESTROY
    when Webhook::Topics::PLACED_ORDER_EVENT
      message = I18n.t('admin.events.message',
                       action: I18n.t('admin.events.placed'),
                       subject: I18n.t('admin.events.order'), 
                       user_name: [@current_user.first_name, @current_user.last_name].map(&:capitalize).join(" "))
      verb = Event::Verbs::PLACED
      arguments << @subject.email

    when Webhook::Topics::CREATE_PRODUCT_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.created'), 
                       subject: I18n.t('admin.events.product'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::CREATE
      arguments << @subject.name
    when Webhook::Topics::UPDATE_PRODUCT_EVENT
      message = I18n.t('admin.events.message',
                       action: I18n.t('admin.events.updated'),
                       subject: I18n.t('admin.events.product'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
      arguments << @subject.name
    when Webhook::Topics::DELETE_PRODUCT_EVENT
      message = I18n.t('admin.events.message',
                       action: I18n.t('admin.events.deleted'),
                       subject: I18n.t('admin.events.product'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::DESTROY
      arguments << @subject.name

    when Webhook::Topics::CREATE_COLLECTION_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.created'),
                       subject: I18n.t('admin.events.collection'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::CREATE
      arguments << @subject.name
    when Webhook::Topics::UPDATE_COLLECTION_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.updated'),
                       subject: I18n.t('admin.events.collection'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
      arguments << @subject.name
    when Webhook::Topics::DELETE_COLLECTION_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.deleted'),
                       subject: I18n.t('admin.events.collection'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::DESTROY
      arguments << @subject.name

    when Webhook::Topics::CREATE_PAGE_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.created'),
                       subject: I18n.t('admin.events.page'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::CREATE
      arguments << @subject.title
    when Webhook::Topics::UPDATE_PAGE_EVENT
      message = I18n.t('admin.events.message',
                       action: I18n.t('admin.events.updated'),
                       subject: I18n.t('admin.events.page'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
      arguments << @subject.title
    when Webhook::Topics::DELETE_PAGE_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.deleted'),
                       subject: I18n.t('admin.events.page'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::DESTROY
      arguments << @subject.title

    when Webhook::Topics::CREATE_CUSTOMER_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.created'), 
                       subject: I18n.t('admin.events.customer'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::CREATE
      arguments << @subject.email
    when Webhook::Topics::UPDATE_CUSTOMER_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.updated'), 
                       subject: I18n.t('admin.events.customer'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
      arguments << @subject.email
    when Webhook::Topics::DELETE_CUSTOMER_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.deleted'), 
                       subject: I18n.t('admin.events.customer'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::DESTROY
      arguments << @subject.email

    when Webhook::Topics::CREATE_USER_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.created'), 
                       subject: I18n.t('admin.events.user'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::CREATE
      arguments << @subject.email
    when Webhook::Topics::UPDATE_USER_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.updated'), 
                       subject: I18n.t('admin.events.user'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
      arguments << @subject.email
    when Webhook::Topics::DELETE_USER_EVENT
      message = I18n.t('admin.events.message',
                       action: I18n.t('admin.events.deleted'), 
                       subject: I18n.t('admin.events.user'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::DESTROY
      arguments << @subject.email

    when Webhook::Topics::CREATE_WEBHOOK_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.created'), 
                       subject: I18n.t('admin.events.webhook'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::CREATE
    when Webhook::Topics::UPDATE_WEBHOOK_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.updated'), 
                       subject: I18n.t('admin.events.webhook'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
    when Webhook::Topics::DELETE_WEBHOOK_EVENT
      message = I18n.t('admin.events.message', 
                       action: I18n.t('admin.events.deleted'), 
                       subject: I18n.t('admin.events.webhook'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::DESTROY

    when Webhook::Topics::UPDATE_SHOP_EVENT
      message = I18n.t('admin.evthe managementents.message',
                       action: I18n.t('admin.events.updated'), 
                       subject: I18n.t('admin.events.shop'), 
                       user_name: @current_user.full_name)
      verb = Event::Verbs::UPDATE
      arguments << @subject.name
      @event.update_attributes(subject_id: shop_id)
    else
      fail(ArgumentError)
    end
    @event.update_attributes(subject_type: @class,
                             arguments: arguments,
                             message: message,
                             shop_id: shop_id,
                             verb: verb) || fail(ArgumentError)
  end
end
