class AddDescriptionColumnToEmailTemplates < ActiveRecord::Migration[4.2]
  def change
    add_column :email_templates, :description, :string
  end
end
