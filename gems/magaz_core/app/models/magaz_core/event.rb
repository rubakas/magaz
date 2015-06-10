module MagazCore
  class Event < ActiveRecord::Base
    self.table_name = 'events'

    belongs_to :shop
    belongs_to :subject, polymorphic: true

    validates_presence_of :verb, :message, :subject_id, :subject_type

    def description
      case self.verb
      when 'destroy'
        I18n.t('default.models.events.description', subject_class_name: self.subject_type.split('::').last.downcase,
                                                                 action: I18n.t('default.models.events.destroyed'))
      when 'create'
        I18n.t('default.models.events.description', subject_class_name: self.subject_type.split('::').last.downcase,
                                                                 action: I18n.t('default.models.events.created'))
      when 'update'
        I18n.t('default.models.events.description', subject_class_name: self.subject_type.split('::').last.downcase,
                                                                 action: I18n.t('default.models.events.updated'))
      end
    end
  end
end