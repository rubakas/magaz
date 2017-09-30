class RenameTypeColumnInEmailTemplates < ActiveRecord::Migration[4.2]
  def change
    rename_column :email_templates, :type, :template_type  
  end
end
