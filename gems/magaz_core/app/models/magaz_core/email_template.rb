module MagazCore
  class EmailTemplate < ActiveRecord::Base
    belongs_to :shop

    self.table_name = 'email_templates'

    EMAIL_TEMPLATES = YAML.load_file("#{Rails.root}/config/email_templates/email_templates.yml")
  end
end
