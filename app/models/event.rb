class Event < ActiveRecord::Base

  belongs_to :shop
  belongs_to :subject, polymorphic: true

  def description
    case self.verb
    when 'destroy'
      I18n.t('default.models.events.description', 
             subject_class_name: self.subject_type.split('::').last.downcase,
             action: I18n.t('default.models.events.destroyed'))
    when 'create'
      I18n.t('default.models.events.description', 
             subject_class_name: self.subject_type.split('::').last.downcase,
             action: I18n.t('default.models.events.created'))
    when 'update'
      I18n.t('default.models.events.description', 
             subject_class_name: self.subject_type.split('::').last.downcase,
             action: I18n.t('default.models.events.updated'))
    end
  end

  module Verbs
    CREATE = "create".freeze
    UPDATE = "update".freeze
    DESTROY = "destroy".freeze
    PLACED = "placed".freeze
  end
end
