class CreateClassenrolls < ActiveRecord::Migration
  def change
    create_table :classenrolls do |t|
      t.integer :user_id
      t.integer :classroom_id
      t.boolean :ista

      t.timestamps
    end
    add_index :classenrolls, :user_id
    add_index :classenrolls, :classroom_id
  end
end
