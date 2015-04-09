class AddDescriptionColumnToEmailTemplates < ActiveRecord::Migration
  def change
    add_column :email_templates, :description, :string
  end
end
