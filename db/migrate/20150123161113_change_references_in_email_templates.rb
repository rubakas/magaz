class ChangeReferencesInEmailTemplates < ActiveRecord::Migration[4.2]
  def change
    remove_column :email_templates, :subscriber_notification_id
    add_reference :email_templates, :shop
  end
end
