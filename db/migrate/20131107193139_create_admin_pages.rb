class CreateAdminPages < ActiveRecord::Migration
  def change
    create_table :admin_pages do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
