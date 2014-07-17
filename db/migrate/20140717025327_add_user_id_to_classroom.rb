class AddUserIdToClassroom < ActiveRecord::Migration
  def change
    add_column :classrooms, :user_id, :integer
    add_index :classrooms, :user_id
  end
end
