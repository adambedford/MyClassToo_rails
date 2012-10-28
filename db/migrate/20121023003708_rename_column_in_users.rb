class RenameColumnInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :colleges_id, :college_id
  end
end
