class EditUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.text   :permissions, array: true, default: []
      t.string :user_type
    end
  end
end
