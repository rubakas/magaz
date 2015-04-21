class EditEventReferenceToPolymorphic < ActiveRecord::Migration
  def change
    add_index :events, :subject_id
  end
end
