module MagazCore
  class Event < ActiveRecord::Base
    self.table_name = 'events'

    belongs_to :shop
    belongs_to :subject, polymorphic: true

    # VERB = ['create', 'update', 'destroy', 'placed']

     validates_presence_of :verb, :message, :description, :subject_id, :subject_type
    # validates :verb, inclusion: VERB
  end
end