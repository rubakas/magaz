module MagazCore
  class EmailTemplate < ActiveRecord::Base
    belongs_to :shop

    self.table_name = 'email_templates'

    EMAIL_TEMPLATES = YAML.load_file("#{Rails.root}/config/locales/en.yml")["en"]["templates"]
  end
end
