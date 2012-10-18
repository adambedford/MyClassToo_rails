class CreateClassEntries < ActiveRecord::Migration
  def change
    create_table :class_entries do |t|

      t.references :class_list
      t.string :recurrence
      t.string :start_time
      t.string :end_time
      t.string :professor_name
      t.references :user
      t.string :calendar_code

      t.timestamps
    end
  end
end
