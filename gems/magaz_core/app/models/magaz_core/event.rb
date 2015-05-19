module MagazCore
  class Event < ActiveRecord::Base
    self.table_name = 'events'

    belongs_to :shop
    belongs_to :subject, polymorphic: true

    validates_presence_of :verb, :message, :subject_id, :subject_type

    def description
      case self.verb
      when 'destroy'
        I18n.t('activerecord.models.events.description', subject_class_name: self.subject_type.split('::').last.downcase,
                                                         action: I18n.t('activerecord.models.events.destroyed'))
      when 'create'
        I18n.t('activerecord.models.events.description', subject_class_name: self.subject_type.split('::').last.downcase,
                                                         action: I18n.t('activerecord.models.events.created'))
      when 'update'
        I18n.t('activerecord.models.events.description', subject_class_name: self.subject_type.split('::').last.downcase,
                                                         action: I18n.t('activerecord.models.events.updated'))
      end
    end

    module Roles
      CREATE_PRODUCT_EVENT = "Product creation".freeze
      UPDATE_PRODUCT_EVENT = "Product update".freeze
      DELETE_PRODUCT_EVENT = "Product deletion".freeze
      UPDATE_ORDER_EVENT = "Order update".freeze
      CREATE_COLLECTION_EVENT = "Collection creation".freeze
      UPDATE_COLLECTION_EVENT = "Collection update".freeze
      DELETE_COLLECTION_EVENT = "Collection deletion".freeze
      CREATE_CUSTOMER_EVENT = "Customer creation".freeze
      UPDATE_CUSTOMER_EVENT = "Customer creation".freeze
      DELETE_CUSTOMER_EVENT = "Customer deletion".freeze

    end

    def path
      ['/admin/', self.subject_type.split('::').last.downcase, 's', '/', self.id].join
    end
  end
end