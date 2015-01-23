class CreateMagazCoreEmailTemplates < ActiveRecord::Migration
  def change
    create_table :magaz_core_email_templates do |t|

      t.timestamps null: false
    end
  end
end
