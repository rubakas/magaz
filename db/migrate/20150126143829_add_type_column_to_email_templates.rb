class AddTypeColumnToEmailTemplates < ActiveRecord::Migration[4.2]
  def change
    add_column :email_templates, :type, :string
  end
end
