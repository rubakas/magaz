module MagazCore
  class Webhook < ActiveRecord::Base
    self.table_name = 'webhooks'

    belongs_to :shop
    has_many :events, as: :subject

    FORMAT_CHOICE = ["JSON", "XML"]

    module Topics

      CREATE_PRODUCT_EVENT = "create_product_event"
      UPDATE_PRODUCT_EVENT = "update_product_event"
      DELETE_PRODUCT_EVENT = "delete_product_event"

      CREATE_COLLECTION_EVENT = "create_collection_event"
      UPDATE_COLLECTION_EVENT = "update_collection_event"
      DELETE_COLLECTION_EVENT = "delete_collection_event"

      CREATE_CUSTOMER_EVENT = "create_customer_event"
      UPDATE_CUSTOMER_EVENT = "update_customer_event"
      DELETE_CUSTOMER_EVENT = "delete_customer_event"

      UPDATE_ORDER_EVENT = "update_order_event"
      UPDATE_SHOP_EVENT = "update_shop_event"

      CREATE_ARTICLE_EVENT = "create_article_event"
      UPDATE_ARTICLE_EVENT = "update_article_event"
      DELETE_ARTICLE_EVENT = "delete_article_event"

      CREATE_BLOG_EVENT = "create_blog_event"
      UPDATE_BLOG_EVENT = "update_blog_event"
      DELETE_BLOG_EVENT = "delete_blog_event"

      CREATE_COMMENT_EVENT = "create_comment_event"
      UPDATE_COMMENT_EVENT = "update_comment_event"
      DELETE_COMMENT_EVENT = "delete_comment_event"

      CREATE_PAGE_EVENT = "create_page_event"
      UPDATE_PAGE_EVENT = "update_page_event"
      DELETE_PAGE_EVENT = "delete_page_event"

      CREATE_USER_EVENT = "create_user_event"
      UPDATE_USER_EVENT = "update_user_event"
      DELETE_USER_EVENT = "delete_user_event"

      WEBHOOKS_TOPICS_LIST = ["#{CREATE_PRODUCT_EVENT}", "#{UPDATE_PRODUCT_EVENT}", "#{DELETE_PRODUCT_EVENT}",
                              "#{CREATE_COLLECTION_EVENT}", "#{UPDATE_COLLECTION_EVENT}", "#{DELETE_COLLECTION_EVENT}",
                              "#{CREATE_CUSTOMER_EVENT}", "#{UPDATE_CUSTOMER_EVENT}", "#{DELETE_CUSTOMER_EVENT}",
                              "#{UPDATE_ORDER_EVENT}", "#{UPDATE_SHOP_EVENT}"]
    end

    validates :topic, inclusion: MagazCore::Webhook::Topics::WEBHOOKS_TOPICS_LIST
    validates :format, inclusion: FORMAT_CHOICE

    validates :address, presence: true,
                        format: { with: /https?:\/\/[\S]+/ }

  end
end