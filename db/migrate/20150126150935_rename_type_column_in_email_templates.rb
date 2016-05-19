class RenameTypeColumnInEmailTemplates < ActiveRecord::Migration
  def change
    rename_column :email_templates, :type, :template_type  
  end
end
