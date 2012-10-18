class RenameClassListsTable < ActiveRecord::Migration
  def change
    rename_table :class_lists, :class_list
  end
end
