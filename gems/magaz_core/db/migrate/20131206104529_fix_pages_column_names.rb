class FixPagesColumnNames < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.rename :name, :title
      t.rename :description, :content
    end
  end
end
