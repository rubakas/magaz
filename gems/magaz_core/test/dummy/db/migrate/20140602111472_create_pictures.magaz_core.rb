# This migration comes from magaz_core (originally 20140121145515)
class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|

      t.timestamps
    end
  end
end
