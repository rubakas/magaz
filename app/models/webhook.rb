class Webhook < ActiveRecord::Base
  belongs_to :shop

  module Topics

    CREATE_PRODUCT_EVENT = "create_product_event".freeze
    UPDATE_PRODUCT_EVENT = "update_product_event".freeze
    DELETE_PRODUCT_EVENT = "delete_product_event".freeze

    CREATE_COLLECTION_EVENT = "create_collection_event".freeze
    UPDATE_COLLECTION_EVENT = "update_collection_event".freeze
    DELETE_COLLECTION_EVENT = "delete_collection_event".freeze

    CREATE_CUSTOMER_EVENT = "create_customer_event".freeze
    UPDATE_CUSTOMER_EVENT = "update_customer_event".freeze
    DELETE_CUSTOMER_EVENT = "delete_customer_event".freeze

    UPDATE_ORDER_EVENT = "update_order_event".freeze
    PLACED_ORDER_EVENT = "placed_order_event".freeze
    DELETE_ORDER_EVENT = "delete_order_event".freeze

    UPDATE_SHOP_EVENT = "update_shop_event".freeze

    CREATE_ARTICLE_EVENT = "create_article_event".freeze
    UPDATE_ARTICLE_EVENT = "update_article_event".freeze
    DELETE_ARTICLE_EVENT = "delete_article_event".freeze

    CREATE_BLOG_EVENT = "create_blog_event".freeze
    UPDATE_BLOG_EVENT = "update_blog_event".freeze
    DELETE_BLOG_EVENT = "delete_blog_event".freeze

    CREATE_COMMENT_EVENT = "create_comment_event".freeze
    UPDATE_COMMENT_EVENT = "update_comment_event".freeze
    DELETE_COMMENT_EVENT = "delete_comment_event".freeze

    CREATE_PAGE_EVENT = "create_page_event".freeze
    UPDATE_PAGE_EVENT = "update_page_event".freeze
    DELETE_PAGE_EVENT = "delete_page_event".freeze

    CREATE_USER_EVENT = "create_user_event".freeze
    UPDATE_USER_EVENT = "update_user_event".freeze
    DELETE_USER_EVENT = "delete_user_event".freeze

    CREATE_WEBHOOK_EVENT = "create_webhook_event".freeze
    UPDATE_WEBHOOK_EVENT = "update_webhook_event".freeze
    DELETE_WEBHOOK_EVENT = "delete_webhook_event".freeze

    WEBHOOKS_TOPICS_LIST = [CREATE_PRODUCT_EVENT, UPDATE_PRODUCT_EVENT, DELETE_PRODUCT_EVENT,
                            CREATE_COLLECTION_EVENT, UPDATE_COLLECTION_EVENT, DELETE_COLLECTION_EVENT,
                            CREATE_CUSTOMER_EVENT, UPDATE_CUSTOMER_EVENT, DELETE_CUSTOMER_EVENT,
                            UPDATE_ORDER_EVENT, UPDATE_SHOP_EVENT]

  end

  FORMAT_CHOICE = ["JSON", "XML"]

  validates :topic, inclusion: Topics::WEBHOOKS_TOPICS_LIST
  validates :format, inclusion: FORMAT_CHOICE
  validates :address, presence: true,
                      format: { with: /https?:\/\/[\S]+/ }

end
