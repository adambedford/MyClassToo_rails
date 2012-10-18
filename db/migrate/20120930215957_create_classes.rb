class CreateClasses < ActiveRecord::Migration
  def change
    create_table :classes do |t|
      t.string :course_id
      t.references :college
      t.text :class_name

      t.timestamps
    end
    add_index :classes, :college_id
  end
end
