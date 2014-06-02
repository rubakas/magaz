# This migration comes from magaz_core (originally 20131206104529)
class FixPagesColumnNames < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.rename :name, :title
      t.rename :description, :content
    end
  end
end
