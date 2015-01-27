module MagazCore
  class EmailTemplate < ActiveRecord::Base
    belongs_to :shop
    before_create :default_values

    self.table_name = 'email_templates'

    VARIABLES = YAML.load_file("#{Rails.root}/config/email_templates/email_templates.yml")

    def default_values
      self.name ||= VARIABLES['new_order_notification']['name']
      self.title ||= VARIABLES['new_order_notification']['title']
      self.body ||= VARIABLES['new_order_notification']['body']
      self.template_type ||= VARIABLES['new_order_notification']['template_type']
    end
  end
end
