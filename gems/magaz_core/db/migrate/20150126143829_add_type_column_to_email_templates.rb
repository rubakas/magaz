class AddTypeColumnToEmailTemplates < ActiveRecord::Migration
  def change
    add_column :email_templates, :type, :string
  end
end
