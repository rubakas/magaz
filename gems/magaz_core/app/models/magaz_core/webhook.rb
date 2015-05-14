module MagazCore
  class Webhook < ActiveRecord::Base
    self.table_name = 'webhooks'

    belongs_to :shop
    EVENT_CHOICE = [I18n.t('activerecord.models.webhooks.product_creation'),
                    I18n.t('activerecord.models.webhooks.product_update'),
                    I18n.t('activerecord.models.webhooks.product_deletion'),
                    I18n.t('activerecord.models.webhooks.order_update'),
                    I18n.t('activerecord.models.webhooks.collection_creation'),
                    I18n.t('activerecord.models.webhooks.collection_update'),
                    I18n.t('activerecord.models.webhooks.collection_deleton'),
                    I18n.t('activerecord.models.webhooks.customer_creation'),
                    I18n.t('activerecord.models.webhooks.customer_update'),
                    I18n.t('activerecord.models.webhooks.customer_deletion')]
    FORMAT_CHOICE = ["JSON", "XML"]


    validates :topic, inclusion: EVENT_CHOICE
    validates :format, inclusion: FORMAT_CHOICE

    validates :address, presence: true,
                        format: { with: /https?:\/\/[\S]+/ }
    validates :topic, inclusion: EVENT_CHOICE
    validates :format, inclusion: FORMAT_CHOICE
  end
end