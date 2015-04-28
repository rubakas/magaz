module MagazCore
  class Event < ActiveRecord::Base
    self.table_name = 'events'

    belongs_to :shop
    belongs_to :subject, polymorphic: true

    validates_presence_of :verb, :message, :subject_id, :subject_type

    def description
      unless self.verb == 'destroy'
        ending = I18n.t('activerecord.models.events.d')
      else
        ending = I18n.t('activerecord.models.events.ed')
      end
      [I18n.t('activerecord.models.events.the'), ' ',self.subject_type.split('::').last.downcase, ' ', I18n.t('activerecord.models.events.was'), ' ', self.verb, ending].join
    end

    def path
      ['/admin/', self.subject_type.split('::').last.downcase, 's', '/', self.id].join
    end
  end
end