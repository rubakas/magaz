class AddAttributessToEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :name
      t.string :title
      t.text :body

      t.references :subscriber_notification
      t.timestamps
    end
  end
end
