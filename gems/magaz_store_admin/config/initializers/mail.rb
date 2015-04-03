SMTP_SETTINGS = YAML.load_file("#{Rails.root}/config/mailer_settings.yml")[Rails.env]["smtp_settings"]
MAILER_SETTINGS = YAML.load_file("#{Rails.root}/config/mailer_settings.yml")[Rails.env]["default"]

ActionMailer::Base.smtp_settings = SMTP_SETTINGS