module MagazCore
  class EmailTemplate < ActiveRecord::Base
    belongs_to :shop
    before_create :default_values

    self.table_name = 'email_templates'

    def default_values
      self.name ||= 'Order Notification'
      self.title ||= 'New order'
      self.body ||= 'You have a new order'
    end
  end
end
