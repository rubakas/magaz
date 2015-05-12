module MagazCore
  class Webhook < ActiveRecord::Base
    self.table_name = 'webhooks'

    belongs_to :shop
    EVENT_CHOICE = [I18n.t('activerecord.models.webhooks.product_creation'),
                    I18n.t('activerecord.models.webhooks.product_update'),
                    I18n.t('activerecord.models.webhooks.product_deletion')]
    FORMAT_CHOICE = ["JSON", "XML"]

    validates :topic, inclusion: EVENT_CHOICE
    validates :format, inclusion: FORMAT_CHOICE

    validates :address, presence: true,
                        format: { with: /https?:\/\/[\S]+/ }
  end
end