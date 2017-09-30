class CreateLinks < ActiveRecord::Migration[4.2]
  def change
    create_table :links do |t|
      t.string         :name
      t.string         :link_type
      t.integer        :position
      t.string         :subject
      t.string         :subject_params
      t.integer        :subject_id
      t.references     :link_list
    end
  end
end
