class AddNameandLocationtoColleges < ActiveRecord::Migration
  def up
    change_table :colleges do |t|
      t.string :name
      t.string :city
      t.string :state, :limit => 2
    end
  end

  def down
    remove_column :colleges, :name
    remove_column :colleges, :city
    remove_column :colleges, :state
  end
end
